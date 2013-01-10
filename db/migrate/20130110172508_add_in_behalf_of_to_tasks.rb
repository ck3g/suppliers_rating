class AddInBehalfOfToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :in_behalf_of, :string
  end
end
