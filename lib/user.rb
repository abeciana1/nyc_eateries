class User < ActiveRecord::Base
  has_many :reviews
  has_many :restaurants, through: :reviews

  def write_review(restaurant)
    puts "How many stars do you rate this restaurant? Enter *"
    rating = gets.chomp
    puts "Please write your review (up to 255 characters)."
    review = gets.chomp
    Review.create(star_rating: rating, desc: review, user_id: self, restaurant_id: restaurant.id)
  end
end