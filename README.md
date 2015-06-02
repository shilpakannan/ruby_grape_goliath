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
    
Now let's list all the posts in the database:

    curl http://localhost:9000/v1/posts.json
    => []

A blank array in response tells us there are no posts yet.

## Adding a Post

    curl -X POST -d '{"post":{"title":"David Jones","body":"this is my message"}}' http://localhost:9000/v1/posts/create

Now list all the posts again

    curl http://localhost:9000/v1/posts.json
    => [{"body":"this is my message","created_at":"2012-05-11T13:35:03-07:00","id":1,"title":"David Jones","updated_at":"2012-05-11T13:35:03-07:00"}]

Your first post has now shown up.

# Next Steps

This is just a basic Grape API example. You can see the post API specified in `app/api/posts.rb`. You could expand that API and add your own models in `app/models`. Grape's readme has some [basic usage examples](https://github.com/intridea/grape#basic-usage) that will help get you started.

### Locally, you can:

Drop your database:

    rake db:drop

Create your database:

    rake db:create

Migrate your database:

    rake db:migrate

Create and migrate your database:

    rake db:setup

