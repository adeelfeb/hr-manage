class DocumentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.user_type == "admin"
        scope.all
      else
        scope.where(employee_id: user.id)
      end
    end
  end

  def show?
    user_is_owner_or_admin?
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user_is_owner_or_admin?
  end

  def edit?
    update?
  end

  def destroy?
    user_is_owner_or_admin?
  end

  private

  def user_is_owner_or_admin?
    user.user_type == "admin" || record.employee_id == user.id
  end
end
