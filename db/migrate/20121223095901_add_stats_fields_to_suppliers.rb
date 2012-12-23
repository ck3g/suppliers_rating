class AddStatsFieldsToSuppliers < ActiveRecord::Migration
  def change
    add_column :suppliers, :contacts, :string
    add_column :suppliers, :pay_to, :string
    add_column :suppliers, :total_amount, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
