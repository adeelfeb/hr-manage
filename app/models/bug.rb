class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :user  # QA creator
  belongs_to :developer, class_name: "User", optional: true  # Assigned developer

  has_one_attached :image

  enum :progress_state, {
    newly_reported: 0,
    being_fixed: 1,
    resolved: 2,
    verified_by_qa: 3,
    closed: 4
  }

  enum :bug_category, {
    feature_request: 0,
    bug_error: 1
  }

  validates :title, presence: true, uniqueness: { scope: :project_id }
  validates :bug_category, presence: true
  validates :progress_state, presence: true

  validate :validate_image

  def validate_image
    return unless image.attached?

    if !image.content_type.in?(%w[image/png image/gif])
      errors.add(:image, "must be a PNG or GIF")
    elsif image.byte_size > 5.megabytes
      errors.add(:image, "size should be less than 5MB")
    end
  end
end
