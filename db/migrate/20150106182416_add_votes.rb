class AddVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id, null: false
      t.integer :review_id, null: false
      t.integer :vote_value, null: false
    end
      add_index :votes, :review_id
  end
end
