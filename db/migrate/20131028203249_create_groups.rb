class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.decimal :amount

      t.timestamps
    end
  end
end
