# # require 'uri'
# require 'net/http'
# require 'openssl'
require "pry"
require "json"
require "json-prettyprint"

# url = URI("https://yelp-com.p.rapidapi.com/search/nearby/40.7420/-73.9073?offset=0&radius=16.0934&term=Restaurants")
# # binding.pry

# http = Net::HTTP.new(url.host, url.port)
# http.use_ssl = true
# http.verify_mode = OpenSSL::SSL::VERIFY_NONE

# request = Net::HTTP::Get.new(url)
# request["x-rapidapi-host"] = 'yelp-com.p.rapidapi.com'
# request["x-rapidapi-key"] = '''

# response = http.request(request)
# data = JSON.pretty_generate(JSON.parse(response.body))
# res = JSON.parse(data) 

# # def self.restaurant(hash)
# arr = []

# search = res["business_search_results"].collect do |x|
#     x["business"]["is_yelp_guaranteed"] == false
# end

# binding.pry


# binding.pry
#

#* t.string "name" -- res["business_search_results"][x]["business"]["ios_search_indexing_info"]["title"]
#* t.string "address" -- res["business_search_results"][x]["business"]["addresses"]["primary_language"]["long_form"]
#* t.string "menu_link"
#* t.string "website" -- -- res["business_search_results"][x]["business"]["ios_search_indexing_info"]["webpage_url"]["ios_search_indexing_info"]["webpage_url"]
#* t.string "yelp_page" #! remove column
#* t.string "hours"
#* t.string "phone" -- res["business_search_results"][x]["business"]["localized_phone"]
#* t.text "about" --
#* t.string "neighborhood" -- res["business_search_results"][x]["business"]["neighborhoods"][0]
#* t.boolean "credit_card"
#* t.boolean "reservations"
#* t.integer "cuisine_id"

# ["business_search_results"][0][]
