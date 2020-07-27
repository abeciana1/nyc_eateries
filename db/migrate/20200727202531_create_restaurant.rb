class CreateRestaurant < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :menu_link
      t.string :website
      t.string :yelp_page
      t.string :hours
      t.string :phone
      t.text :about
      t.string :neighborhood
      t.boolean :credit_card
      t.boolean :reservations
    end
  end
end
