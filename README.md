# ruby_grape_goliath
# [Grape](https://github.com/intridea/grape) + [Goliath](https://github.com/postrank-labs/goliath) Example REST API

## What is this?

* Grape is micro-framework for creating REST-like APIs in Ruby.
* Goliath is a non-blocking Ruby web server

Together you can create a highly scalable API and use the nice features of Grape to specify how your REST API will work.

## Getting Started

First take a copy of the project

    git clone https://github.com/shilpakannan/ruby_grape_goliath.git
    cd ruby_grape_goliath/

Install dependencies

    bundle install

Next create and migrate your database

    rake db:setup

Finally start the server and you're done!

    ruby server.rb -vs
    
### Locally, you can:

Drop your database:

    rake db:drop

Create your database:

    rake db:create

Migrate your database:

    rake db:migrate

Create and migrate your database:

    rake db:setup

