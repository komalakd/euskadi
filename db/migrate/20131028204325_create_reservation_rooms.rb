class CreateReservationRooms < ActiveRecord::Migration
  def change
    create_table :reservation_rooms do |t|
      t.integer :reservation_id
      t.references :reservation_item, polymorphic: true
      t.decimal :amount
      t.date :since
      t.date :until

      t.timestamps
    end
  end
end
