class HomePolicy < ApplicationPolicy
  def show?
    user.present? # Any logged-in user can view home, customize further if needed
  end

  def manager_view?
    user&.user_type == "manager"
  end

  def developer_view?
    user&.user_type == "developer"
  end

  def qa_view?
    user&.user_type == "qa"
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
