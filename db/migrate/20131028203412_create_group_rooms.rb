class CreateGroupRooms < ActiveRecord::Migration
  def change
    create_table :group_rooms do |t|
      t.integer :room_id
      t.integer :group_id

      t.timestamps
    end
  end
end
