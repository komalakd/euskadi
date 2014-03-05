class CreateRoomPassengers < ActiveRecord::Migration
  def change
    create_table :room_passengers do |t|
      t.integer :reservation_room_id
      t.integer :passenger_id

      t.timestamps
    end
  end
end
