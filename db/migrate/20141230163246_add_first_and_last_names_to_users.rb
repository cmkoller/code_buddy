class AddFirstAndLastNamesToUsers < ActiveRecord::Migration
  class User < ActiveRecord::Base; end

  def up
    add_column :users, :display_name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    User.update_all(display_name: "Anonymous")
    change_column :users, :display_name, :string, null: false
  end

  def down
    remove_column :users, :first_name
    remove_column :users, :last_name
  end
end
