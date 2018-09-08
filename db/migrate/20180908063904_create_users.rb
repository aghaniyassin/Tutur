class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :sexe
      t.string :first_name
      t.string :last_name
      t.string :crypted_password
      t.string :salt
      t.string :description
    end
  end
end
