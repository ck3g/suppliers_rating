# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-email-#{n}@example.com" }
    password "secret"
    password_confirmation "secret"
  end
end
