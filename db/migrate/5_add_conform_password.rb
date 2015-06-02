class AddConformPassword < ActiveRecord::Migration
  def change
    add_column :users, :comform_password, :string
  end
end