require "pry"
require 'colorize'

class CLI
    
    def self.run
        CLI.greet

        1.times do
            puts "If this your first time here, please type 'create' (without quotes) to create an account.".yellow
            puts "\n"
            puts "Otherwise, please type 'login' (without quotes) to log into your account!"
            puts "\n"
            puts "PLEASE REMEMBER ALL COMMANDS ARE CASE SENSITIVE".red
            puts "\n"
            puts "You may type 'exit' anytime to exit the program."
            log_create_input = gets.chomp

            break if log_create_input == "exit"

            case log_create_input
            when "create"
                CLI.create_account
            when "login"
                logged_in = User.login
                CLI.main_menu(logged_in)
                puts "\n"
                puts "\n"
            else
                puts "Sorry we didn't understand the command you entered. Please try again!".red
                puts "\n"
                puts "Would you like to restart the app? (Y/N)"
                restart = gets.chomp
                if restart == "Y" || restart == "y"
                    puts "Restarting the app now ..."
                    CLI.greet 
                else
                    puts "No problem, come back anytime."
                end
            end
        end


    end

    def self.greet
        puts "dP   dP   dP          dP                                     "
        puts "88   88   88          88                                     "
        puts "88  .8P  .8P .d8888b. 88 .d8888b. .d8888b. 88d888b. .d8888b. "
        puts "88  d8'  d8' 88ooood8 88 88'  `"" 88'  `88 88'  `88 88ooood8 "
        puts "88.d8P8.d8P  88.  ... 88 88.  ... 88.  .88 88    88 88.  ... "
        puts "8888' Y88'   `88888P' dP `88888P' `88888P' dP    dP `88888P' "
        puts "ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo"
        puts "\n"
        puts "  dP            "
        puts "  88            "
        puts "d8888P .d8888b. "
        puts "  88   88'  `88 "
        puts "  88   88.  .88 "
        puts "  dP   `88888P' "
        puts "oooooooooooooooo"
        puts "\n"
        puts "888888ba  dP    dP  a88888b. "
        puts "88    `8b Y8.  .8P d8'   `88 "
        puts "88     88  Y8aa8P  88        "
        puts "88     88    88    88        "
        puts "88     88    88    Y8.   .88 "
        puts "dP     dP    dP     Y88888P' "
        puts "ooooooooooooooooooooooooooooo"
        puts " \n"
        puts " 88888888b            dP                     oo                   "
        puts " 88                   88                                          "
        puts "a88aaaa    .d8888b. d8888P .d8888b. 88d888b. dP .d8888b. .d8888b. "
        puts " 88        88'  `88   88   88ooood8 88'  `88 88 88ooood8 Y8ooooo. "
        puts " 88        88.  .88   88   88.  ... 88       88 88.  ...       88 "
        puts " 88888888P `88888P8   dP   `88888P' dP       dP `88888P' `88888P' "
        puts "oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo"
        puts "\n"
        puts "A place created for foodies, by foodies!".yellow
        puts "\n"
    end

    def self.create_account
        puts "What's your first name?"
        user_first_name = gets.chomp
        puts "Thanks, #{user_first_name}, what's your last name?"
        user_last_name = gets.chomp
        puts "Please create a username:"
        username_create = gets.chomp
        puts "One more thing, please create a password:"
        user_password_create = gets.chomp
        User.create(first_name: user_first_name, last_name: user_last_name, username: username_create, password: user_password_create)
        puts "Thanks, #{user_first_name}, thanks for creating your account."
        puts "We're going to exit you out of the app now and then you can use the 'login' option."
        CLI.run
    end

    def self.main_menu(logged_in)
        CLI.main_options(logged_in)
        logged_input = STDIN.gets.chomp

        case logged_input
        when "1" #* go to restaurant menu
            CLI.restaurant_search_menu(logged_in)
        when "2" #* show/update review
            logged_in.update_review if logged_in.check_user_has_reviews
            CLI.main_options(logged_in)
        when "3" #* remove review
            logged_in.remove_review if logged_in.check_user_has_reviews
            CLI.main_options(logged_in)
        when "4" #* change password
            puts "Sure, you can change your password!"
            puts "\n"
            puts "Please enter your old password:"
            old_password = gets.chomp
            puts "Thanks, now enter your new password:"
            new_password = gets.chomp
            logged_in.change_password(old_password, new_password)
        when "5"
            exit
        else
            puts "Sorry, we counldn't understand your request, please choose one of the commands above. Thanks!"
            CLI.main_menu(logged_in)
        end

        CLI.menu_helper(logged_in, logged_input)
    end

    def self.main_options(user)
        puts "Hey #{user.first_name}, here's a menu of options to choose from:"
        puts "\n"
        puts "Press 1 -- to go to restaurant search menu" 
        puts "Press 2 -- to show/update one of your past reviews." 
        puts "Press 3 -- to delete one of your past reviews."
        puts "Press 4 -- to change your password."
        puts "Press 5 -- to exit from this app."
        puts "\n"
    end

    def self.restaurant_search_menu(user)
        self.restaurant_search_options(user)
        logged_input = gets.chomp

        case logged_input
        when "1" #search by name." 
            Restaurant.search_by_name(user)
        when "2" #search by neighborhood."
            Restaurant.search_by_neighborhood
        when "3" #recieve a random restaurant." 
            Restaurant.find_random_by_neighborhood
        when "4" #receive curated cuisine recommendations." 
            Restaurant.recommendations_by_cuisine
        when "5" #go back to the main menu
            CLI.main_menu(user)
        when "6" #exit from this app"
            exit
        else
            "Sorry, we counldn't understand your request, please choose one of the numbers above. Thanks!"
            CLI.restaurant_search_menu(user)
        end

        CLI.menu_helper(user, logged_input)
    end

    def self.restaurant_search_options(user)
        puts "Hey #{user.first_name}, this a menu of restaurant search options:"
        puts "\n"
        puts "Press 1 -- to search by name." 
        puts "Press 2 -- to search by neighborhood."
        puts "Press 3 -- to recieve a random restaurant." 
        puts "Press 4 -- to receive curated cuisine recommendations." 
        puts "Press 5 -- to go back to main menu."
        puts "Press 6 -- to exit from this app"
        puts "\n"
    end

    def self.menu_helper(user, logged_input)
        if logged_input != "1" && logged_input != "2" && logged_input != "3" && logged_input != "4" && logged_input != "5" && logged_input != "6"
            puts "Sorry, we counldn't understand your request, please choose one of the numbers above. Thanks!"
        end

        puts "\n"
        puts "Is there anything else you would like to do? (Y/N)"
        additional_task = gets.chomp
        puts "\n"

        case additional_task
        when "Y" || "y"
            puts "No problem, we'll return you to the main menu options!"
            CLI.main_menu(user)
        when "N" || "n"
            puts "No problem, please login when you would like to do something else! Goodbye, #{user.first_name}!"
            exit
        end

        if additional_task != "Y" || "y" && !additional_task != "N" || "n"
            puts "Sorry, we couldn't understand your response. Please type 'Y' for yes or 'N' for no. Thanks!"
            puts "\n"
            puts "Otherwise, you can exit and then log back in later if there's a specific task that you would like to do. Thanks!"
            puts "\n"
            CLI.main_menu(user)
        end
    end

end