class Project < ApplicationRecord
  belongs_to :user  # manager

  has_many :project_assignments, dependent: :destroy
  has_many :users, through: :project_assignments  # Developers and QAs

  has_many :bugs, dependent: :destroy

  validates :title, presence: true, uniqueness: true

  validate :only_assign_non_managers

  private

  def only_assign_non_managers
    if users.any? { |u| u.role == "is_manager" }
      errors.add(:users, "cannot assign managers to a project")
    end
  end
end
