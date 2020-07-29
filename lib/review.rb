class Review < ActiveRecord::Base
    belongs_to :user
    belongs_to :restaurant

    def stars(num_stars)
      
      case num_stars
      when 1
        puts "*".bold
      when 2
        puts "* *".bold
      when 3
        puts "* * *".bold
      when 4
        puts "* * * *".bold
      when 5
        puts "* * * * *".bold
      end
    end

    def self.new_review_on_page(star_rating, desc, user, restaurant)
        Review.create(star_rating: star_rating, desc: desc, user_id: user.id, restaurant_id: restaurant.id)
        # (star_rating: 5, desc: "food was good", user_id: alex.id, restaurant_id: rest1.id)
    end

    def pretty_display
          puts "\n"
          puts "#{self.stars(self.star_rating)}created on: #{self.created_at}"
          puts "======================================================================="
          puts "'#{self.desc}''"
          puts "\n"
          puts "by #{self.user.first_name} #{self.user.last_name.first}.".italic
          puts "======================================================================="
      end
end