# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :supplier do
    name { Faker::Name.name }
    rank 0
  end
end
