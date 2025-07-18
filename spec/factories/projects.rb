FactoryBot.define do
  factory :project do
    sequence(:title) { |n| "Project #{n}" }
    association :user, factory: :user  # this is the manager
  end
end
