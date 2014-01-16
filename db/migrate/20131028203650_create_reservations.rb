class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :passenger_id
      t.integer :enterprise_id
      t.decimal :amount
      t.text :observation

      t.timestamps
    end
  end
end
