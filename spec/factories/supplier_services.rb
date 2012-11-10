# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :supplier_service do
    supplier
    service
    price "9.99"

    factory :invalid_supplier_service do
      price -1
    end
  end
end
