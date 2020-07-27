class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :star_rating, :default => "*"
      t.string :desc, :default => " "
      t.timestamp :created_at
      t.timestamp :updated_at
      t.integer :user_id
      t.integer :restaurant_id
    end
  end
end
