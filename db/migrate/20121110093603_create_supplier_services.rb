class CreateSupplierServices < ActiveRecord::Migration
  def change
    create_table :supplier_services do |t|
      t.integer :supplier_id
      t.integer :service_id
      t.decimal :price, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
    add_index :supplier_services, [:supplier_id, :service_id]
  end
end
