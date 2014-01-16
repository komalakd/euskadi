class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :number
      t.boolean :active
      t.decimal :amount
      t.integer :room_type_id
      t.integer :group_id
      t.integer :page_id

      t.timestamps
    end
  end
end
