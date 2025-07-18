FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    name { "Test User" }
    role { :is_developer }
    confirmed_at { Time.current }  # if you're using Devise confirmable
  end
end
