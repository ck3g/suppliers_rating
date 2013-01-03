class AddStatusToComments < ActiveRecord::Migration
  def change
    add_column :comments, :status, :string
    add_index :comments, :status
  end
end
