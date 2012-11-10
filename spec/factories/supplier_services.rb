# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :supplier_service do
    association :supplier
    association :service
    price "9.99"
  end
end
