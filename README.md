# NOTICE
* This project is out of date and badly needs refactoring.
* Refactor to Rails 4.
* Test coverage, however, is solid.

# Welcome to Devblog

Tired of blogging platforms that make you use themes and plugins?

Devblog is a Ruby on Rails blogging engine, written to allow precise control over your site functionality and views.

## Features
* 100% valid sitemap.
* 100% valid atom feed, although the blog is designed to use Feedburner as the public feed in the \<head\>.  This way, you can track subscribers.
* Contact form.
* Different layouts for the blog admin and regular site.
* Split Gem installed for easy A/B Split testing.
* Uses Devise for authentication of the blog admin.
* Blog admin has a separate layout for managing posts.
* Blog posts accept markdown for the content.
* Outsources blog comments to Disqus.
* Twitter bootstrap for front end.
* 404, 500, etc. elegant error code handling in production.
* Google Analytics
* Keeps track of popular blog posts.

## Setup
* lib/devblog_extensions.rb - Change static variables to match your website.
* Add your smtp production email settings in config/production.rb.

### Database
* Uses PostgresQL for all environments (because of Heroku).  You'll need to set up a Postgres server on your development machine.  (Use Homebrew to set up local postgres.)
* Change database.yml to match your local machine.  Or, change it entirely to use another database.

### Split Config
* config/initializers/split.rb - Change the username and password to access the Split Dashboard.
* config/split.yml - Update 'production' with your redis instance.  (Example redis hosts:  RedisToGo.com or Redis4You.com)
* You'll need to install a local redis server for development.  (Hint: Use Homebrew)

## Use
1. Visit '/admin' to sign up as the blog admin to manage posts.  The current environment only allows 1 admin per site.  
2. If you add any pages outside the articles views, you will need to add entries in the sitemap view.
3. For stylesheet assets, if you want to customize the application stylesheets add them to the app/asets/stylesheets/application directory.  If you want to customize the blog admin pages (where you manage posts), add stylesheets to the app/asets/stylesheets/blog_admin directory.
