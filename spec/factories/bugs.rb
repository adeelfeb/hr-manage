FactoryBot.define do
  factory :bug do
    sequence(:title) { |n| "Bug #{n}" }
    bug_category { :feature_request }
    progress_state { :newly_reported }
    association :user, factory: :user, role: :is_qa
    association :developer, factory: :user, role: :is_developer
    project
  end
end
