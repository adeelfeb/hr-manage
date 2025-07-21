class ProjectPolicy < ApplicationPolicy

  def index?
    # !@user.is_qa?
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
