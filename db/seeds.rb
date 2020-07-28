User.delete_all
Restaurant.delete_all
Review.delete_all
# Community.delete_all
# Cuisine.delete_all
require "pry"

# * User

alex = User.find_or_create_by(first_name: "Alex", last_name: "Beciana", username: "alexb", password: "password")
junko = User.find_or_create_by(first_name: "Junko", last_name: "Tahara", username: "junkot", password: "pass")

#  * Restaurant
rest1 = Restaurant.find_or_create_by(name: "European Republic", address: "123 fake street, Huntinton, NY, 11743", menu_link: "http://www.google.com", website: "http://www.google.com", yelp_page: "http://www.google.com", hours: "open", phone: "(555) 555-5555", about: "food", neighborhood: "Astoria", credit_card: true, reservations: false)


#  * Review
review1 = Review.find_or_create_by(star_rating: 5, desc: "food was good", user_id: alex.id, restaurant_id: rest1.id)

# * Community


binding.pry
