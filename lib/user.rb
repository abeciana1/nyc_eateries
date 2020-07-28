class User < ActiveRecord::Base
  has_many :reviews
  has_many :restaurants, through: :reviews

  def write_review(restaurant)
    puts "How many stars do you rate this restaurant? Enter *"
    rating = gets.chomp
    puts "Please write your review (up to 255 characters)."
    review = gets.chomp
    Review.create(star_rating: rating, desc: review, user_id: self, restaurant_id: restaurant.id)
    puts "Your review is posted!"
  end
  
  def update_review(restaurant)
    puts "How many stars do you re-rate this restaurant? Enter *"
    rating = gets.chomp
    puts "Please update your review (up to 255 characters)."
    review = gets.chomp
    past_review = reviews.find_by  restaurant_id: restaurant.id
    past_review.star_rating = rating
    past_review.desc = review
    puts "Your review is updated!"
  end
end