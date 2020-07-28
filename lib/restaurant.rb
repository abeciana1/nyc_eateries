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

  def self.recommendation(cuisine)
    list = all.where(cuisine_id: cuisine.id)
      .select {|r| r.average_star_count >= 4 }
      .sort_by { |r| !r.average_star_count }
      .take(5)
  end
end