FactoryBot.define do
  factory :user do
    name Faker::Name.name
    sequence(:email) { |n| "email#{n}@factory.com" }
    password { Faker::Number.number(8) }
  end
end
