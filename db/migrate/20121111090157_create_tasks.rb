class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :supplier_service_id
      t.string :title
      t.text :description
      t.decimal :cost, precision: 10, scale: 2
      t.string :status, default: "open"
      t.integer :rating
      t.datetime :finished_at

      t.timestamps
    end
    add_index :tasks, :supplier_service_id
    add_index :tasks, :status
  end
end
