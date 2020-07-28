class CreateCuisinesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :cuisines do |t|
      t.string :name
    end
  end
end
