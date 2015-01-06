class AddBuddyIdColumn < ActiveRecord::Migration
  def change
    add_column :reviews, :buddy_id, :integer, null: false

  end
end
