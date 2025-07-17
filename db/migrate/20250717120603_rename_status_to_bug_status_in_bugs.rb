class RenameStatusToBugStatusInBugs < ActiveRecord::Migration[7.0]
  def change
    rename_column :bugs, :status, :bug_status
    add_index :bugs, :developer_id

  end
end
