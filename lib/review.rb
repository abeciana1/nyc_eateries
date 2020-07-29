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

    def nice_display
          puts "\n"
          puts "#{self.stars(self.star_rating)}created on: #{self.created_at}"
          puts "======================================================================="
          puts "'#{self.desc}'"
          puts "\n"
          puts "by #{self.user.first_name} #{self.user.last_name.first}.".italic
          puts "======================================================================="
      end

    def self.all_restaurants_reviewed(user)
        user.reviews.each_with_index do |review, index|
            puts "\n"
            puts "#{index + 1}: #{review.restaurant.name}\ncreated on: #{review.created_at} //" 
            puts "#{review.stars(review.star_rating)}"
        end
    end

    def self.select_review(user)
        self.all_restaurants_reviewed(user)
        input = STDIN.gets.chomp.to_i
        puts "==========="
        puts "Your Review:"
        puts "==========="
        rev = all.where(id: user.reviews[input - 1].id)
        rev[0].nice_display
        rev[0]
    end
end