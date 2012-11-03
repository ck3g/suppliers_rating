class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name
      t.decimal :rating, default: 0, scale: 2

      t.timestamps
    end
    add_index :suppliers, :name
  end
end
