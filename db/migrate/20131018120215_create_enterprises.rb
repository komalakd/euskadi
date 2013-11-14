class CreateEnterprises < ActiveRecord::Migration
  def change
    create_table :enterprises do |t|
      t.string :cuit
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
