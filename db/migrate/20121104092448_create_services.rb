class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name

      t.timestamps
    end
    add_index :services, :name
  end
end
