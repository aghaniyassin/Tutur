class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.integer :brand
      t.integer :model
      t.integer :year
      t.integer :energy
      t.integer :doors
      t.integer :transmission
      t.integer :category
      t.integer :mileage
      t.integer :stars
      t.integer :price, default: 0
      t.boolean :active
      t.string :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
