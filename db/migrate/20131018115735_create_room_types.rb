class CreateRoomTypes < ActiveRecord::Migration
  def change
    create_table :room_types do |t|
      t.string :denomination
      t.decimal :amount

      t.timestamps
    end
  end
end
