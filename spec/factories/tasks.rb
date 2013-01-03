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

    factory :closed_task do
      status "closed"
      finished_at Time.current
    end

    factory :paid_task do
      paid true
    end

    factory :costless_task do
      cost nil
    end
  end
end
