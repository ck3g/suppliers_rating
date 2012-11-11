# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    supplier_service
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    cost "9.99"
    status "open"
    rating 5

    factory :invalid_task do
      title nil
    end
  end
end
