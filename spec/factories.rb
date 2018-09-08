FactoryBot.define do
  factory :user do
    sequence(:first_name) { Faker::Name.name }
    sequence(:last_name)  { Faker::Name.name }

    sequence(:email)      { Faker::Internet.email }
    sequence(:password)   { Faker::Lorem.characters(6) }
  end
end
