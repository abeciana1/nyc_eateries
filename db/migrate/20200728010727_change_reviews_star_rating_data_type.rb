class ChangeReviewsStarRatingDataType < ActiveRecord::Migration[6.0]
  def change
    change_column :reviews, :star_rating, :integer
  end
end
