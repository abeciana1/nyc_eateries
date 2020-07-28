class RemoveUserRestaurantCuisines < ActiveRecord::Migration[6.0]
  def change
    remove_column :cuisines, :user_id
    remove_column :cuisines, :restaurant_id
  end
end
