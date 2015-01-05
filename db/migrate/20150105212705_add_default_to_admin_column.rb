class AddDefaultToAdminColumn < ActiveRecord::Migration
  def change
      remove_column :users, :admin, :boolean
      add_column :users, :admin, :boolean, default: false, null: false
  end
end
