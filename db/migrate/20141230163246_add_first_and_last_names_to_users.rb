class AddFirstAndLastNamesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, null: false, default: "FirstName"
    add_column :users, :last_name, :string
  end
end
