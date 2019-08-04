class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :distance
      t.boolean :drinks
      t.boolean :brunch
      t.string :website

      t.timestamps
    end
  end
end
