require "colorize"

class Restaurant < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

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
    # credit_card ? cc = "Yes" : cc = "No"
    # reservations ? rsv = "Yes" : rsv = "No"
    # puts "Menu: #{menu_link}\nWebsite: #{website}\nYelp page: #{yelp_page}\nBusiness hour: #{hours}\nAbout this restaurant: #{about}\nAccept creadit card?: #{cc}\nAccept reservations?: #{rsv}"

    puts "======================================================================================================"
    puts "#{self.name} || #{self.address} || #{self.phone}".yellow.bold
    puts "======================================================================================================"
    puts "We're rated an average of #{self.average_star_count} out of 5 stars, based on #{self.reviews.count} review(s)!"
    puts "======================================================================================================"
    puts "\n"
    puts "Visit us at #{self.website}".colorize(:light_blue)
    puts "Find us on Yelp #{self.yelp_page}".colorize(:light_blue)
    puts "======================================================================================================"
    puts "Feeling hundry? Find something on our menu, it's all good!"
    puts "#{self.menu_link}"
    puts "\n"
    puts "Accept Credit Cards? #{self.credit_card ? cc = "Yes" : cc = "No"}   ||    Take Reservations? #{self.reservations ? rsv = "Yes" : rsv = "No"}"
    puts "======================================================================================================"
    puts "Want to know more about us?"
    puts "#{self.about}"
    puts "======================================================================================================"
    puts "Check out reviews from customers:"
    puts "======================================================================================================"
    self.pretty_display_reviews
    puts "Have you visited us recently? Give us some feedback!"
    puts "\n"
    puts "If you would like to create a review for this restaurant, please enter 'Y' for yes or 'N' for no."
    start_new_review = STDIN.gets.chomp

    case start_new_review
    when "Y" || "y"
      puts "Great, please type number of stars you would rate your last visit in integer format:"
      star_input = STDIN.gets.chomp
      puts "Okay, time to be descriptive, please give details:"
      desc_input = STDIN.gets.chomp
      puts "Please confirm your username by typing it below:"
      username = STDIN.gets.chomp
      user = User.find_by(username: username)
      review = Review.create(star_rating: star_input.to_i, desc: desc_input, user_id: user.id, restaurant_id: self.id)
      puts "Thanks for reviewing #{self.name}, we look forward to reading it!"
      puts "\n"
      puts "Here's what your review looks like:"
      review.pretty_display
      puts "To update this review, you will need to go to the main menu and choose menu option '2'."
      # ask Y/N to go back to the main menu 
      # if yes - CLI.main_menu(user)
      # if no - exit and say goodbye
    when "N" || "n"
      puts "No problem! You should come by sometime and we'll work hard to make your visit memorable."
      # ask Y/N to go back to the main menu 
      # if yes - CLI.main_menu(user)
      # if no - exit and say goodbye
    end
    #* in cli - gets.chomp before method and find_by to invoke this method
    #* in cli - add question to go back to main menu (Y/N) -- 
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

  def pretty_display_reviews
    self.reviews.each do |review|
      puts "\n"
      puts "#{review.stars(review.star_rating)}created on: #{review.created_at}"
      puts "======================================================================="
      puts "'#{review.desc}'"
      puts "\n"
      puts "by #{review.user.first_name} #{review.user.last_name.first}.".italic
      puts "======================================================================="
    end
  end

end