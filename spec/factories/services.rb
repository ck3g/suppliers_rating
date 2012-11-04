# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service do
    sequence(:name) { |n| "Service Name ##{n}" }
  end
end
