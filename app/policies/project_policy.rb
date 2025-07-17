class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.is_manager?
        scope.where(user_id: user.id)
      else
        scope.joins(:project_assignments).where(project_assignments: { user_id: user.id })
      end
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    user.is_manager?
  end

  def create?
    user.is_manager?
  end

  def edit?
    user.is_manager? && record.user_id == user.id
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
