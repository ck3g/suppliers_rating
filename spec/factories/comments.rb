# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    message { Faker::Lorem.sentence }

    factory :invalid_comment do
      message ""
    end
  end
end
