require "bundler/capistrano"
require 'yaml'

desc "Run on LIVE server" 
task :live do 
  server "50.116.25.171", :web, :app, :db, primary: true
  set :environment, "live"
end 

set :application, "events"
set :user, "root"
set :deploy_to, "/home/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :bundle_without, [:darwin, :development, :test]

set :scm, "git"
set :repository, "git@github.com:andypike/events.gg.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx_#{environment}.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/nginx_#{environment}.conf /etc/nginx/sites-available/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/example.database.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"

  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=production"
  end
  
  desc "enable the maintenance message"
  task :enable_maintenance do
    run "cd #{current_path}/public && mv _maintenance.html maintenance.html"
  end

  desc "disable the maintenance message"
  task :disable_maintenance do
    run "cd #{current_path}/public && mv maintenance.html _maintenance.html"
  end

  desc "Backup the remote postgreSQL database"
  task :backup do
    # First lets get the remote database config file so that we can read in the database settings
    tmp_db_yml = "tmp/database.yml"
    get("#{shared_path}/config/database.yml", tmp_db_yml)
 
    # load the settings within the database file for the current environment
    db = YAML::load_file("tmp/database.yml")["production"]
    run_locally("rm #{tmp_db_yml}")

    time_stamp = Time.now.to_i
    filename = "#{application}_#{environment}.dump.#{time_stamp}.sql.bz2"
    file = "/tmp/#{filename}"
    on_rollback {
      run "rm #{file}"
      run_locally("rm #{tmp_db_yml}")
    }
    run "pg_dump --clean --no-owner --no-privileges -U#{db['username']} -h localhost #{db['database']} | bzip2 > #{file}" do |ch, stream, out|
      ch.send_data "#{db['password']}\n" if out =~ /^Password:/
      puts out
    end
    run_locally "mkdir -p -v '#{File.dirname(__FILE__)}/../backups/'"
    get file, "backups/#{filename}"
    run "rm #{file}"
  end

  desc "Deploys all parts of the systems and restarts workers"
  task :all do
    deploy.enable_maintenance
    deploy.stop
    deploy.backup
    deploy.migrate
    deploy.start
    deploy.disable_maintenance
  end
  before "deploy:all", "deploy"
end

# $ cap uat rails:console
# $ cap uat rails:db
namespace :rails do
  %w[console db].each do |command|
    desc "rails #{command} command on the remote server"
    task command, roles: :app, except: {no_release: true} do
      hostname = find_servers_for_task(current_task).first
      exec "ssh -l #{user} #{hostname} -t 'source ~/.profile && #{current_path}/script/rails #{command} production'"
    end
  end
end