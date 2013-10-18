class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :number
      t.boolean :active

      t.timestamps
    end
  end
end
