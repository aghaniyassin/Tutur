require_relative'./helpers'

FactoryBot.define do
  factory :user do
    sequence(:first_name) { Faker::Name.name }
    sequence(:last_name)  { Faker::Name.name }

    sequence(:email)      { Faker::Internet.email }
    sequence(:password)   { Faker::Lorem.characters(6) }
    sequence(:description)   { Faker::Lorem.characters(6) }
  end

  factory :car do
    sequence(:brand)        { Car.brands.keys.sample }
    sequence(:model)        { Car.models.keys.sample }
    sequence(:year)         { rand(2000..Time.now.year) }
    sequence(:energy)       { Car.energies.keys.sample }
    sequence(:transmission) { Car.transmissions.keys.sample }
    sequence(:category)     { Car.categories.keys.sample }
    sequence(:mileage)      { Car.mileages.keys.sample }
    sequence(:description)  { Faker::Lorem.paragraph }
    sequence(:price)        { rand(10..100) }
    sequence(:doors)        { [3,5].sample }
    sequence(:street)       { Faker::Address.street_name }
    sequence(:city)         { Faker::Address.city }
    sequence(:postal_code)  { Faker::Address.zip }
    sequence(:latitude)     { Faker::Address.latitude }
    sequence(:longitude)    { Faker::Address.longitude }

    after(:build) { |car| Helpers.stub_with(car) }

    user
  end

  factory :rental do
    sequence(:start_at)        { rand(1..10).day.since }
    sequence(:end_at)          { rand(10..20).day.since }
    car
    user
  end
end
