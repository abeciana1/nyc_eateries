class ChangeReviewsStarRatingDataType < ActiveRecord::Migration[6.0]
  def up
    change_column :reviews, :star_rating, :integer
  end
  
  def down
    change_column :reviews, :star_rating, :string
  end
end
