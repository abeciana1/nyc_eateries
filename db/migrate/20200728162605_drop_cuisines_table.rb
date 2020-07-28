class DropCuisinesTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :cuisines
  end
end
