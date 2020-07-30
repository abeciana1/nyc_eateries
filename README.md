# NYC Eateries

![Restaurant_picture](images/restaurant_image.jpeg)

### Developed by Alex Beciana and Junko Tahara

## Specs

* VSCode Text Editor

## Language
* Ruby v.2.7.1

### Gems Used
* `gem "activerecord", '~> 5.2'`
* `gem "sinatra-activerecord"`
* `gem "sqlite3", '~> 1.3.6'`
* `gem "pry"`
* `gem "require_all"`

## How to Install Run the Application

- [ ] Fork this repository

- [ ] Clone your own branch

- [ ] Open your terminal

- [ ] Navigate to the correct directory

- [ ] Make sure that your are in the parent directory

- [ ] Run `bundle install` in your terminal to make sure you have all of the necessary gems installed

- [ ] Run `rake db:migrate` to migratae tables to set up the database tables

- [ ] Run `rake db:seed` to populate the database tables with sample data

- [ ] To test that everything works, you may run `rake cosole` to make sure sample data has been added

- [ ] Run `ruby bin/run.rb` within your terminal

## Structure

### Class Associations

* User has many reviews
* Restaurant has many reviews
* Review belongs to user and restaurant.
* Cusine has many restaurants
* Cuisine belongs to Restaurant


## User Stories

* As a user, I want to be able to search for restaurants.
* As a user, I want to be able to create, update, and delete reviews for a specific restaurant
* As a user, I want to receive recommendations based on similar attributes of a restaurant
* As a user, I want to see all the details and reviews for a specific restaurant
* As a user, I want to be able to create an account and login to it.

## Video Demo

[![Project Demo](https://res.cloudinary.com/marcomontalbano/image/upload/v1596142659/video_to_markdown/images/google-drive--1Q3NXBnPn42-58CC8Xl9uyrcsX8nAKYt3-4834888bcd2b4555e72811f2a6951e10.jpg)](https://drive.google.com/file/d/1Q3NXBnPn42-58CC8Xl9uyrcsX8nAKYt3/view?usp=sharing "Project Demo")


