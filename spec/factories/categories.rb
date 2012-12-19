# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "category-#{n}" }

    factory :invalid_category do
      name ""
    end
  end
end
