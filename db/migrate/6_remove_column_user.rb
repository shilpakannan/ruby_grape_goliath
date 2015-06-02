class RemoveColumnUser < ActiveRecord::Migration
  def change
    remove_column :users, :comform_password, :string
    remove_column :users, :password, :string
  end
end