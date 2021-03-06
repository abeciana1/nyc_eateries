require_relative './cli.rb'

class User < ActiveRecord::Base
    has_many :reviews
    has_many :restaurants, through: :reviews

    def self.login
        puts "Hey, what's your username?"
        username_input = STDIN.gets.chomp
        puts "Thanks, please type in your password:"
        password_input = STDIN.gets.chomp
        logged_in = User.find_by(username: username_input)
        if !User.find_by(username: username_input) && !User.find_by(password: password_input)
            puts "Sorry your entry wasn't valid. Please try logging in again or create an account."
            User.login
        elsif !User.find_by(username: username_input) || !User.find_by(password: password_input)
            puts "Sorry, either your username or password was incorrect. Please try again."
            puts "\n"
            User.login
        elsif logged_in.username == username_input && logged_in.password == password_input
            puts "\n"
            puts "Welcome back, #{logged_in.first_name}"
            puts "\n"
            logged_in
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

    def check_user_has_reviews
        if self.reviews == nil || self.reviews == [] 
            puts "Sorry, you don't seem to have any reviews yet, please check out some restaurants near you and a create one."
            puts "We're checking our database."
            return false
        else
            puts "Looks like you have #{self.reviews.count} review(s)."
            return true
        end
    end

    def update_review
        puts "Which review would you like to update?"
        puts "Please enter the number of the review:"
        rev = Review.select_review(self)
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
            when "no change"
                puts "No change in description."
                puts "We'll send you back to the main menu."
            else
                puts "Sorry we didn't quite catch that, please try again."
                puts "\n"
                self.update_review
            end
        when "N" || "n"
            puts "No problem, we'll send you back to the main menu."
        end
    end

    def remove_review
        puts "Which review do you want to delete?"
        puts "Please enter the number of review:"
        rev = Review.select_review(self)
        puts "=========================================================="
        puts "Please review the following before deleting your review:"
        puts "=========================================================="
        puts "\n"
        puts "You rated #{rev.restaurant.name} #{rev.star_rating} stars out of 5 stars."
        puts "\n"
        puts "Your description was: #{rev.desc}"
        puts "=========================================================="
        puts "Would you like to delete this review? Please type 'Y' for yes or 'N' for no."
        delete_review = STDIN.gets.chomp

        case delete_review
        when "Y" || "y"
            rev.delete
            puts "Your review has been deleted."
        when "N" || "n"
            puts "No problem, we'll send you back to the main menu."
        end
    end

    def change_password(old_password, new_password)
        if check_password(old_password)
            self.update(password: new_password)
            puts "Your password has been changed."
        else
            puts "Sorry you didn't enter the correct password. Please try again."
        end
    end

    private

    def check_password(password)
        if self.password == password
            true
        else
            false
        end
    end
  

end