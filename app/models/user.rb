class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  enum :role, { is_developer: 0, is_qa: 1, is_manager: 2 }

  # This is the manager of the project
  has_many :created_projects, class_name: "Project", foreign_key: :user_id

  # This is the assigned relationship (QA/Dev)
  has_many :project_assignments
  has_many :assigned_projects, through: :project_assignments, source: :project

  # Bug relationships
  has_many :created_bugs, class_name: "Bug", foreign_key: :creator_id
  has_many :assigned_bugs, class_name: "Bug", foreign_key: :developer_id
end
