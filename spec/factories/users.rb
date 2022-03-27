FactoryBot.define do
  factory :user do
    sequence(:id) { |n| n }
    name { "Test" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "testtest" }
    password_confirmation { password }
  end
end
