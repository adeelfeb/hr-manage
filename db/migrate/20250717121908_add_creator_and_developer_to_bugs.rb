class AddCreatorAndDeveloperToBugs < ActiveRecord::Migration[8.0]
  def change
    add_column :bugs, :creator_id, :integer
    add_column :bugs, :developer_id, :integer
    add_foreign_key :bugs, :users, column: :creator_id
add_foreign_key :bugs, :users, column: :developer_id

  end
end
