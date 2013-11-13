events.gg
=========

What's this all about then?
---------------------------

ESports tournaments are happening all the time for various games but it's hard for fans to keep up as there is no single canonical source tracking when and where these tournaments are taking place. This project is aiming to bridge that gap by allowing organisations that run ESports tournaments to add their information and then give fans the tools to never miss a match again.

A word on the code for this project
-----------------------------------

I'm using this project as a way to experiment with a few things:

* [7 Patterns to Refactor Fat ActiveRecord Models](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/)
* [Rubocop](https://github.com/bbatsov/rubocop)

Setup
-----

```
$ git clone git@github.com:andypike/events.gg.git
$ cd events.gg
$ cp config/example.database.yml config/database.yml
$ psql postgres
  # create user events with password '' CREATEDB;
  # \q
$ brew install qt
$ brew install imagemagick
$ bundle
$ rake db:create db:migrate
$ bundle exec rails s
```
