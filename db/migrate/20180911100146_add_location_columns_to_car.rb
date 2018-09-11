class AddLocationColumnsToCar < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :street, :string
    add_column :cars, :city, :string
    add_column :cars, :postal_code, :string
    add_column :cars, :country, :string
    add_column :cars, :latitude, :float
    add_column :cars, :longitude, :float
  end
end
