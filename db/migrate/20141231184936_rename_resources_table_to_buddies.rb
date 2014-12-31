class RenameResourcesTableToBuddies < ActiveRecord::Migration
  def change
    rename_table :resources, :buddies
  end
end
