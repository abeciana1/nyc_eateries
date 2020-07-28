class User < ActiveRecord::Base
    has_many :reviews
    has_many :restaurants, through: :reviews

    def full_name
        "#{self.first_name} #{self.last_name}"        
    end

    def self.login
        puts "Hey, what's your username?"
        username_input = STDIN.gets.chomp
        puts "Thanks, please type in your password:"
        password_input = STDIN.gets.chomp
        logged_in = self.all.find do |user|
            user.username == username_input && user.password == password_input
        end 
    end

    def write_review(restaurant)
        puts "How many stars do you rate this restaurant? Enter the number."
        rating = gets.chomp
        puts "Please write your review:"
        review = gets.chomp
        Review.create(star_rating: rating.to_i.clamp(1, 5), desc: review, user_id: self, restaurant_id: restaurant.id)
        puts "Your review is posted!"
    end

    def reviewed_restaurants
        self.reviews.collect do |review|
            review.restaurant
        end
    end

    def update_review
        puts "Which review would you like to update?"
        puts "Please type the name of the restaurant"
        puts self.all_restaurants_reviewed
        review_select = STDIN.gets.chomp
        rev = select_review(review_select)
        puts "Would you like to update this review for #{rev.restaurant.name}? Please type either 'Y' for yes or 'N' for no."
        update_attribute = STDIN.gets.chomp

        case update_attribute
        when "Y" || "y"
            puts "You rated #{rev.restaurant.name} #{rev.star_rating} out of 5 stars / Last updated at #{rev.updated_at}"
            puts "Please enter your new star rating for the restaurant or simply type 'no change' to move on to description."
            change_rating = STDIN.gets.chomp
            case  change_rating
            when "no change"
                puts "No change in star rating."
            else
                rev.star_rating = change_rating.to_i
            end
            puts "We'll move you on to updating the description"
            puts "=============================="
            puts "Description"
            puts "=============================="
            puts "You wrote: '#{rev.desc}' on #{rev.updated_at}"
            puts "Please enter your new description for the restaurant or simply type 'update' to make a change in your description or 'no change' to move on."
            change_desc = STDIN.gets.chomp
            case change_desc
            when "update"
                puts "Please type your new description!"
                new_description = STDIN.gets
                rev.desc = new_description
                puts "Thanks for your feedback, we'll send you back to the main menu."
                # TODO -- when making CLI, add way to get back to main menu
            when "no change"
                puts "No change in description."
                puts "We'll send you back to the main menu."
            end
        when "N" || "n"
            puts "No problem, we'll send you back to the main menu."
        end
    end

    def remove_review
        puts "Which review do you want to delete?"
        puts "Please type the name of the restaurant"
        puts self.all_restaurants_reviewed
        review_select = STDIN.gets.chomp
        rev = select_review(review_select)
    end


    def all_restaurants_reviewed
        self.reviews.collect do |review|
            puts review.restaurant.name
        end.uniq
    end

    def select_review(restaurant_name)
        self.reviews.find do |review|
            review.restaurant.name == restaurant_name
        end
    end

    def change_password(old_password, new_password)
        if check_password(old_password)
            self.password = new_password
            puts "Your password has been changed."
        else
            puts "Sorry you didn't enter the correct password. Please try again."
        end
    end

    private

    def check_username(username)
        if self.username == username
            true
        else
            false
        end
    end

    def check_password(password)
        if self.password == password
            true
        else
            false
        end
    end
  

end