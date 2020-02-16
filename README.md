# Odin Facebook

| ![screenshot #001](screenshot-001.png)  | ![screenshot #002](screenshot-002.png)  |
| ------------- | ------------- |
| ![screenshot #003](screenshot-003.png)  | ![screenshot #003](screenshot-004.png)  |


## About this repository

This repository stores a Ruby on Rails practice which consists of creating a web service that mimics Facebook. The full description for this practice can be found at the following link: [The Odin Project - Ruby on Rails - Final Project](https://www.theodinproject.com/courses/ruby-on-rails/lessons/final-project).

## Live version

[Odin Facebook @ Heroku](https://feisbuk-elshaka.herokuapp.com)

## Installation and getting started

To run this locally you'll need [PostgreSQL](https://www.postgresql.org/) and [Ruby](ruby-lang.org) on [Rails](rubyonrails.org) properly installed and set-up. If that's your case the following sequence of commands may help you install this project:

```
git clone https://github.com/frederico-miranda/odin-fakebook/
cd 'odin-fakebook'
bundle install
rails db:setup
```

In order for the facebook login integration to work, you'd need to setup the environment variables ADD_ID and APP_SECRET with the valid credentials of a facebook app (You can create one with a facebook developer account). You could then run the server like this:

```
APP_ID=<YOUR APP ID> APP_SECRET=<YOUR APP SECRET> rails s
```

## Authors

[Frederico Miranda](https://github.com/frederico-miranda/)

[Eleazar Meza](https://github.com/elshaka/)
