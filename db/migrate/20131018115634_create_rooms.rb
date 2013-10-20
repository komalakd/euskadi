class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :number
      t.boolean :active
      t.integer :room_type_id

      t.timestamps
    end
  end
end
