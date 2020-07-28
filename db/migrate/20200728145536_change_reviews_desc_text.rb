class ChangeReviewsDescText < ActiveRecord::Migration[6.0]
  def change
    change_column :reviews, :desc, :text
  end
end
