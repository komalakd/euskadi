class CreatePassengers < ActiveRecord::Migration
  def change
    create_table :passengers do |t|
      t.string :dni
      t.string :name
      t.string :lastname
      t.string :phone_number
      t.string :nationality
      t.string :birthdate
      t.string :country
      t.string :province
      t.string :city
      t.string :address
      t.string :proffesion
      t.string :civil_status

      t.timestamps
    end
  end
end
