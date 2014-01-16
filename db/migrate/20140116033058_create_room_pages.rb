class CreateRoomPages < ActiveRecord::Migration
  def change
    create_table :room_pages do |t|
      t.integer :page_id
      t.integer :room_id
      t.integer :order

      t.timestamps
    end
  end
end
