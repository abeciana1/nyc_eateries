require "json"
require "http"
require "optparse"
require "pry"

API_KEY = "b1YkkcmYI-FMl9ReR-Z-y8sCgLny-cXHzpPPKY1oWrVwqGoiyci4gWJQCbW5GNYAnmsOG08J1sN2IrkRvx-m7QB6cfxkwju_8Zl_h7gZ96Gidix_hgIWdFhhICkjX3Yx"


# Constants, do not change these
API_HOST = "https://api.yelp.com"
SEARCH_PATH = "/v3/businesses/search"
BUSINESS_PATH = "/v3/businesses/"  


DEFAULT_BUSINESS_ID = "yelp-san-francisco"
DEFAULT_TERM = "dinner"
DEFAULT_LOCATION = "San Francisco, CA"
SEARCH_LIMIT = 20


# Make a request to the Fusion search endpoint. Full documentation is online at:
# https://www.yelp.com/developers/documentation/v3/business_search
#
# term - search term used to find businesses
# location - what geographic location the search should happen
#
# Examples
#
#   search("burrito", "san francisco")
#   # => {
#          "total": 1000000,
#          "businesses": [
#            "name": "El Farolito"
#            ...
#          ]
#        }
#
#   search("sea food", "Seattle")
#   # => {
#          "total": 1432,
#          "businesses": [
#            "name": "Taylor Shellfish Farms"
#            ...
#          ]
#        }
#
# Returns a parsed json object of the request
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

def create_restaurant(cuisine, location)
  search(cuisine, location)["businesses"].each { |biz|
    biz_name = biz["name"]
    biz_address = biz["location"]["display_address"][0]
    biz_website = biz["url"]
    biz_phone = biz["display_phone"]
    biz_neighborhood = location
    biz_cuisine = Cuisine.find_or_create_by(name: cuisine)
    biz_cuisine_id = biz_cuisine.id
    
    Restaurant.create(name: biz_name,
                      address: biz_address,
                      website: biz_website,
                      phone: biz_phone,
                      neighborhood: biz_neighborhood,
                      cuisine_id: biz_cuisine_id
                    )
  }
end

create_restaurant("Japanese", "Astoria")





# Look up a business by a given business id. Full documentation is online at:
# https://www.yelp.com/developers/documentation/v3/business
# 
# business_id - a string business id
#
# Examples
# 
#   business("yelp-san-francisco")
#   # => {
  #          "name": "Yelp",
  #          "id": "yelp-san-francisco"
  #          ...
  #        }
  #
  # Returns a parsed json object of the request
  def business(business_id)
    url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"
    response = HTTP.auth("Bearer #{API_KEY}").get(url)
    response.parse
  end
  

# options = {}
# OptionParser.new do |opts|
#   opts.banner = "Example usage: ruby sample.rb (search|lookup) [options]"

#   opts.on("-tTERM", "--term=TERM", "Search term (for search)") do |term|
#     options[:term] = term
#   end

#   opts.on("-lLOCATION", "--location=LOCATION", "Search location (for search)") do |location|
#     options[:location] = location
#   end

#   opts.on("-bBUSINESS_ID", "--business-id=BUSINESS_ID", "Business id (for lookup)") do |id|
#     options[:business_id] = id
#   end

#   opts.on("-h", "--help", "Prints this help") do
#     puts opts
#     exit
#   end
# end.parse!


# command = ARGV


# case command.first
# when "search"
#   term = options.fetch(:term, DEFAULT_TERM)
#   location = options.fetch(:location, DEFAULT_LOCATION)

#   raise "business_id is not a valid parameter for searching" if options.key?(:business_id)

#   response = search(term, location)

#   puts "Found #{response["total"]} businesses. Listing #{SEARCH_LIMIT}:"
#   response["businesses"].each {|biz| puts "name: #{biz["name"]} | business_id #{biz["id"]}"}
# when "lookup"
#   business_id = options.fetch(:business_id, DEFAULT_BUSINESS_ID)


#   raise "term is not a valid parameter for lookup" if options.key?(:term)
#   raise "location is not a valid parameter for lookup" if options.key?(:lookup)

#   response = business(business_id)
#   result = JSON.pretty_generate(response)
#   name = response["name"]
#   url = response["url"]
#   phone = response["display_phone"]
#   cuisine = response["categories"][0]["title"]
#   address = response["location"]["display_address"][0]

#   puts "Found business with id #{business_id}:"
#   puts "name: #{name}"
#   puts "url: #{url}"
#   puts "phone: #{phone}"
#   puts "cuisine: #{cuisine}"
#   puts "address: #{address}"
#   # puts JSON.pretty_generate(response)
# else
#   puts "Please specify a command: search or lookup"
# end




# User.delete_all
# Restaurant.delete_all
# Review.delete_all
# Cuisine.delete_all

# # * User
# alex = User.find_or_create_by(first_name: "Alex", last_name: "Beciana", username: "alexb", password: "password")
# junko = User.find_or_create_by(first_name: "Junko", last_name: "Tahara", username: "junkot", password: "pass")

# #  * Cuisine
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

# #  * Review
# review1 = Review.find_or_create_by(star_rating: 5, desc: "food was good", user_id: alex.id, restaurant_id: rest1.id)
# review2 = Review.find_or_create_by(star_rating: 5, desc: "food was good", user_id: alex.id, restaurant_id: rest2.id)
# review3 = Review.find_or_create_by(star_rating: 5, desc: "food was good", user_id: alex.id, restaurant_id: rest3.id)
# review4 = Review.find_or_create_by(star_rating: 5, desc: "food was good", user_id: alex.id, restaurant_id: rest4.id)
# review5 = Review.find_or_create_by(star_rating: 5, desc: "food was good", user_id: alex.id, restaurant_id: rest5.id)
# review6 = Review.find_or_create_by(star_rating: 5, desc: "food was good", user_id: alex.id, restaurant_id: rest6.id)
# review7 = Review.find_or_create_by(star_rating: 3, desc: "food was ok", user_id: junko.id, restaurant_id: rest1.id)
# review8 = Review.find_or_create_by(star_rating: 1, desc: "food was not good", user_id: junko.id, restaurant_id: rest3.id)
# review9 = Review.find_or_create_by(star_rating: 4, desc: "food was good", user_id: junko.id, restaurant_id: rest4.id)
# review10 = Review.find_or_create_by(star_rating: 1, desc: "food was not good", user_id: junko.id, restaurant_id: rest5.id)