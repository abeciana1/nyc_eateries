class Restaurant < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

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
end