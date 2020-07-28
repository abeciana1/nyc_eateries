class ChangeReviewsDescText < ActiveRecord::Migration[6.0]
  def up
    change_column :reviews, :desc, :text
  end

  def down
    change_column :reviews, :desc, :string
  end
end
