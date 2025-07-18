class BugAssignment < ApplicationRecord
  belongs_to :bug
  belongs_to :user

  validate :user_must_be_developer

  private

  def user_must_be_developer
    errors.add(:user, "must be a developer") unless user&.is_developer?
  end
end
