class AddPaidToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :paid, :boolean, default: false
    add_index :tasks, :paid
  end
end
