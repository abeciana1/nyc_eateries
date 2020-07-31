require "json"
require "http"
require "optparse"
require "pry"
require "dotenv"
Dotenv.load

User.delete_all
Restaurant.delete_all
Review.delete_all
Cuisine.delete_all

API_KEY = ENV["YELP_KEY"]

# Constants, do not change these
API_HOST = "https://api.yelp.com"
SEARCH_PATH = "/v3/businesses/search"
BUSINESS_PATH = "/v3/businesses/"  


DEFAULT_BUSINESS_ID = "yelp-san-francisco"
DEFAULT_TERM = "dinner"
DEFAULT_LOCATION = "San Francisco, CA"
SEARCH_LIMIT = 20

#search from API
def search(term, location)
  url = "#{API_HOST}#{SEARCH_PATH}"
  params = {
    term: term,
    location: location,
    limit: SEARCH_LIMIT
  }
  
  response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
  response.parse
end

def create_restaurants(cuisine, location)
  search(cuisine, location)["businesses"].each { |biz|
    biz_name = biz["name"]
    biz_address = biz["location"]["display_address"].join(', ')
    biz_website = biz["url"]
    biz_hour = get_business_hour(biz["id"])
    biz_phone = biz["display_phone"]
    biz_neighborhood = location
    biz_cuisine = Cuisine.find_or_create_by(name: cuisine)
    biz_cuisine_id = biz_cuisine.id
    Restaurant.create(name: biz_name,
                      address: biz_address,
                      website: biz_website,
                      hours: biz_hour,
                      phone: biz_phone,
                      neighborhood: biz_neighborhood,
                      cuisine_id: biz_cuisine_id
                    )
  }
end

#search business details from API
def business(business_id)
  url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"
  response = HTTP.auth("Bearer #{API_KEY}").get(url)
  response.parse
end

def get_business_hour(business_id)
  result = business(business_id)

  return "For business hour, please contact restaurant" if result["hours"].nil?

  open_hour = result["hours"][0]["open"]
  week = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
  hours = open_hour.each_with_object({}) { |item, result|
    if result[item["day"]]
      result[item["day"]] << "#{item["start"]} - #{item["end"]}"
    else
      result[item["day"]] = ["#{item["start"]} - #{item["end"]}"]
    end
  }
  arr = []
  hours.each { |k,v|
    arr << "#{week[k]} #{v.join(' ')}"
  }
  arr
end

create_restaurants("Japanese", "Astoria")
create_restaurants("Middle Eastern", "East Village")
create_restaurants("Brazilian", "Hell's Kitchen")



# # * User
alex = User.find_or_create_by(first_name: "Alex", last_name: "Beciana", username: "alexb", password: "password")
junko = User.find_or_create_by(first_name: "Junko", last_name: "Tahara", username: "junkot", password: "pass")

# # #  * Cuisine
# cuisine1 = Cuisine.create(name: "Japanese")
# cuisine2 = Cuisine.create(name: "Brazilian")
# cuisine3 = Cuisine.create(name: "Middle Eastern")

# #  * Restaurant
# rest1 = Restaurant.find_or_create_by(name: "Kondo", address: "29-13 Broadway, Astoria, NY 11106", menu_link: "http://www.kondorestaurant.com/", website: "http://www.kondorestaurant.com/", yelp_page: "https://www.yelp.com/biz/kondo-astoria", hours: "5:30 pm - 10:30 pm", phone: "(347) 617-1236", about: "Japanese, Sushi Bars, Salad", neighborhood: "Astoria", credit_card: true, reservations: true, cuisine_id: cuisine1.id)

# rest2 = Restaurant.find_or_create_by(name: "New York Pao De Queijo", address: "31-90 30th St, Astoria, NY 11106", menu_link: "https://www.newyorkpaodequeijo.com/", website: "https://www.newyorkpaodequeijo.com/", yelp_page: "yelp.com/biz/pao-de-queijo-astoria-6", hours: "	
# 10:00 am - 12:00 am", phone: "(555) 555-5555", about: "Brazilian restaurant", neighborhood: "Astoria", credit_card: false, reservations: false, cuisine_id: cuisine2.id)

# rest3 = Restaurant.find_or_create_by(name: "Suzuki Shokudo", address: "38-01 31st St, Long Island City, NY 11101", menu_link: "https://www.suzukishokudo.com/", website: "https://www.suzukishokudo.com/", yelp_page: "https://www.yelp.com/biz/suzuki-shokudo-long-island-city", hours: "	
# 11:00 am - 10:00 pm", phone: "(555) 555-5555", about: "Japanese, Sushi, Ramen", neighborhood: "Astoria", credit_card: true, reservations: true, cuisine_id: cuisine1.id)

# rest4 = Restaurant.find_or_create_by(name: "Nakamura", address: "172 Delancey St, New York, NY 10002", menu_link: "https://www.yelp.com/menu/nakamura-new-york", website: "http://www.nakamuranyc.com/", yelp_page: "https://www.yelp.com/biz/nakamura-new-york", hours: "5pm - 9pm", phone: "(555) 555-5555", about: "Ramen", neighborhood: "East Villege", credit_card: true, reservations: false, cuisine_id: cuisine1.id)

# rest5 = Restaurant.find_or_create_by(name: "Mr. Taka", address: "170 Allen St, New York, NY 10002", menu_link: "https://mrtakaramen.webs.com/menu", website: "https://mrtakaramen.webs.com/", yelp_page: "https://www.yelp.com/biz/mr-taka-ramen-new-york", hours: "11:45 am - 9:00 pm", phone: "(555) 555-5555", about: "Ramen", neighborhood: "East Villege", credit_card: true, reservations: false, cuisine_id: cuisine1.id)

# rest6 = Restaurant.find_or_create_by(name: "Ravagh", address: "11 East 30th St, New York, NY 10016", menu_link: "https://ravaghrestaurants.com/", website: "https://ravaghrestaurants.com/", yelp_page: "https://www.yelp.com/biz/ravagh-persian-grill-new-york-2", hours: "11:45 am - 9:00 pm", phone: "(555) 555-5555", about: "Middle East", neighborhood: "East Villege", credit_card: true, reservations: false, cuisine_id: cuisine3.id)

#  * Review
review1 = Review.find_or_create_by(star_rating: 5, desc: "food was good", user_id: alex.id, restaurant_id: Restaurant.find(1).id)
review2 = Review.find_or_create_by(star_rating: 5, desc: "food was good", user_id: alex.id, restaurant_id: Restaurant.find(2).id)
review3 = Review.find_or_create_by(star_rating: 5, desc: "food was good", user_id: alex.id, restaurant_id: Restaurant.find(3).id)
review4 = Review.find_or_create_by(star_rating: 5, desc: "food was good", user_id: alex.id, restaurant_id: Restaurant.find(4).id)
review5 = Review.find_or_create_by(star_rating: 5, desc: "food was good", user_id: alex.id, restaurant_id: Restaurant.find(5).id)
review6 = Review.find_or_create_by(star_rating: 5, desc: "food was good", user_id: alex.id, restaurant_id: Restaurant.find(6).id)
review7 = Review.find_or_create_by(star_rating: 3, desc: "food was ok", user_id: junko.id, restaurant_id: Restaurant.find(1).id)
review8 = Review.find_or_create_by(star_rating: 1, desc: "food was not good", user_id: junko.id, restaurant_id: Restaurant.find(2).id)
review9 = Review.find_or_create_by(star_rating: 4, desc: "food was good", user_id: junko.id, restaurant_id: Restaurant.find(3).id)
review10 = Review.find_or_create_by(star_rating: 1, desc: "food was not good", user_id: junko.id, restaurant_id: Restaurant.find(4).id)