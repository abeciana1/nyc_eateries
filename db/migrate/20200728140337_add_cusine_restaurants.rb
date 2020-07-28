class AddCusineRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :cuisine_id, :integer
  end
end
