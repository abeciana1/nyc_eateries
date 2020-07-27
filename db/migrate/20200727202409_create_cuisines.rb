class CreateCuisines < ActiveRecord::Migration[6.0]
  def change
    create_table :cuisines do |t|
      t.string :name
      t.integer :user_id
      t.integer :restaurant_id
    end
  end
end
