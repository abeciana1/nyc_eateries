require 'pry'

class Restaurant < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

  def self.find_restaurant_by_name
    puts "What is the name of restaurant you are looking for?" 
    input = STDIN.gets.chomp
    result = all.where(name: input)
    search_result(result)
    result
  end

  def self.uniq_locations
    Restaurant.all.map(&:neighborhood).uniq.sort
  end
  
  def self.uniq_locations_with_index
    uniq_locations.each_with_index { |neighborhood, index| 
      puts "#{index + 1}: #{neighborhood}"
    }
  end
  
  def self.find_restaurant_by_neighborhood
    puts "Choose a location from the list below. Enter a number."
    uniq_locations_with_index
    input = STDIN.gets.chomp.to_i
    result = all.where(neighborhood: uniq_locations[input - 1])
    search_result(result)
    result
  end
  
  def self.find_random_restaurant_by_neighborhood
    puts "Choose a location from the list below. Enter a number."
    uniq_locations_with_index
    input = STDIN.gets.chomp.to_i
    list = all.where(neighborhood: uniq_locations[input - 1])
    result = [list.sample]
    search_result(result)
    result
  end
  
  def self.search_result(restaurants)
    case restaurants.count
    when 0
      puts "There is no restaurant matched."
    when 1
      restaurants[0].show_details
    else
      restaurants.each_with_index { |restaurant, index|
        puts index + 1
        restaurant.show_details
      }
    end
  end

  def show_details
    credit_card ? cc = "Yes" : cc = "No"
    reservations ? rsv = "Yes" : rsv = "No"
    puts "#{name}\nAddress: #{address}\nMenu: #{menu_link}\nWebsite: #{website}\nYelp page: #{yelp_page}\nBusiness hour: #{hours}\nAbout this restaurant: #{about}\nAccept creadit card?: #{cc}\nAccept reservations?: #{rsv}"
  end

  def average_star_count
    reviews.inject(0) { |sum, review| 
      sum + review.star_rating
    }.to_f / reviews.count
  end

  def self.recommendation(cuisine)
    all.where(cuisine_id: cuisine.id)
      .select {|r| r.average_star_count >= 4 }
      .sort_by { |r| r.average_star_count }
      .reverse
      .take(5)
  end
end