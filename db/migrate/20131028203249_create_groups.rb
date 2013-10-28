class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.decimal :amount

      t.timestamps
    end
  end
end
