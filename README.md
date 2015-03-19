---
tags: sinatra, controller, crud
languages: ruby
resources: 1
---

# Curation App for The New York Times 

![NYT logo](https://s3-us-west-2.amazonaws.com/web-dev-readme-photos/sinatra/The_New_York_Times_logo.png)

## Contents

* Quick Set Up
* Objective
* Background
* Instructions
* Starting Your Server
* Getting Started
* Resources

## Quick Set Up

This lab uses a database called `bookmarker`. Go ahead and create that now:

```
> createdb bookmarker
```

This lab uses a key from the New York Times to fetch the database with articles. Take a look at the rake task in `lib/tasks/fetch.rb` to see how this works.

Make sure you register for a New York Times account [here](https://myaccount.nytimes.com/register?) if you don't already have one. Then click [here](http://developer.nytimes.com/apps/register) go get your key.

* Call your application something like `Article Bookmarker`. 
* Give the form your blog website. 
* Say you heard about the API from The Flatiron School.
* You must give it permission to access the most popular api so check the box next to `Issue a new key for Most Popular API` when getting a key.

Create a file `.env` from the root of this lab. In your `.env` file, add the following line:

```ruby
NEW_YORK_TIMES_KEY=paste-your-key-here
```

You're putting your key in this `.env` file because it's been added to the `.gitignore` file. You never want to push API keys to GitHub, especially to a public repo, so make sure that when you are working with API key, you keep them in a separate, git ignored file and use the [Dotenv](https://github.com/bkeepers/dotenv) or [Figaro](https://github.com/laserlemon/figaro) gems to access the values.

Now save your `.env` file and run `bundle install`.

## Objective

The focus of this lab to curate lists of articles to read for users. People who log in should be able to save or bookmark *New York Times* articles to read for later. They should also be able to mark articles as read.

*Right click on the link belwo and select "Save Link As...". Once the clip has downloaded, watch it on your computer to see what you're going for.*

[Download video](http://s3-us-west-2.amazonaws.com/web-dev-readme-photos/sinatra/nyt-article-bookmarker.mp4)

You can also visit a live demo [here](https://nyt-bookmarker.herokuapp.com/).

## Instructions

The tests are written in order of increasing difficulty so get them to pass in order. Run your testing suite to get started.

## Starting Your Server

You now have two options to start your server:

* Rackup
  * Type `rackup` in your terminal. You should see the output below. To view the `home` page using rackup, go to [http://localhost:9292/](http://localhost:9292/).
  * Rackup does not automatically refresh itself based on changes you make to your controller so you must stop the server (`control` + `c`) and restart it (`rackup`) to see how the changes you make to the products controller affect your app.
  
```
[TIME] INFO  WEBrick 1.3.1
[TIME] INFO  ruby 2.1.2 (DATE) [x86_64-darwin13.0]
[TIME] INFO  WEBrick::HTTPServer#start: pid=3179 port=9292
```
* Shotgun
  * Type `shotgun` in your terminal. You should see the output below. To view the `home` page using shotgun, go to [http://localhost:9393/](http://localhost:9393/).
  * Unlike Rackup, Shotgun is a  a reloading rack development server. This means it will automatically reload your controllers so you don't need to stop and restart it every time you make a change to your controller.

```
[TIME] INFO  WEBrick 1.3.1
[TIME] INFO  ruby 2.1.2 (DATE) [x86_64-darwin13.0]
[TIME] INFO  WEBrick::HTTPServer#start: pid=3179 port=9292
```

## Getting Started

There will be three tables and models in this lab.

1. Users
  * Users will have two attributes
    1. name (string)
    2. avatar (string)
2. Articles
  * The articles will have four attributes
    1. title (string)
    2. byline (string)
    3. abstract (text)
    4. url (string)
3. Bookmarks
  * Bookmarks are a join table between users and articles. They also have one other attribute, "read". This keeps track of whether the user has read the article yet or not.
    1. article_id
    2. user_id
    3. read (boolean)

This is a test-driven lab so run your testing suite to get started. Once all your tests are passing, run `rake db:migrate`, `rake db:seed`, and `rake fetch`. This will add new articles to your development database. Then run your server and make sure the app functions!

## Resources

* [Sintra CRUD controller example](https://github.com/ryanbriones/dbc-sinatra-crud-example/blob/master/app/controllers/index.rb)
