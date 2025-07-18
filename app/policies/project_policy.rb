class ProjectPolicy < ApplicationPolicy

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
