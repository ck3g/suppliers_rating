class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name
      t.integer :rank, default: 0

      t.timestamps
    end
    add_index :suppliers, :name
  end
end
