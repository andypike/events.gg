events.gg
=========

What's this all about then?
---------------------------

ESports tournaments are happening all the time for various games but it's hard for fans to keep up as there is no single canonical source tracking when and where these tournaments are taking place. This project is aiming to bridge that gap by allowing organisations that run ESports tournaments to add their information and then give fans the tools to never miss a match again.

A word on the code for this project
-----------------------------------

I'm using this project as a way to experiment with a few things:

* [7 Patterns to Refactor Fat ActiveRecord Models](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/) - Trying various options to trim down my models.
* [Hexagonal Rails](http://www.youtube.com/watch?v=CGN4RFkhH2M) - Using interaction/use case classes to encapsulate business logic (especially those that might be used in the web UI and also API) to reduce code duplication.
* [Improved TDD](http://vimeo.com/68375232) - Using less mocks and testing units of work rather than units of code (refactoring current specs at the moment).
* [Rubocop](https://github.com/bbatsov/rubocop) - Evaluation.

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
