class AddEnumsToBugs < ActiveRecord::Migration[7.1]
  def change
    
    add_column :bugs, :progress_state, :integer, default: 0, null: false
    add_column :bugs, :bug_category, :integer, default: 0, null: false

  end
end
