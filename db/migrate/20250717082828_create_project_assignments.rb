class CreateProjectAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :project_assignments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
