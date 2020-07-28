class Restaurant < ActiveRecord::Base
    # belongs_to :cuisine
    has_many :reviews
    has_many :users, through: :reviews

end