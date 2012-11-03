# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :supplier do
    name { Faker::Name.name }
    rating 0.0

    factory :invalid_supplier do
      name ""
      rating -1
    end
  end
end
