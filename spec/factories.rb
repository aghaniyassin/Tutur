FactoryBot.define do
  factory :user do
    sequence(:first_name) { Faker::Name.name }
    sequence(:last_name)  { Faker::Name.name }

    sequence(:email)      { Faker::Internet.email }
    sequence(:password)   { Faker::Lorem.characters(6) }
  end

  factory :car do
    sequence(:brand)        { Car.brands.keys.sample }
    sequence(:model)        { Car.models.keys.sample }
    sequence(:year)         { rand(2000..Time.now.year) }
    sequence(:energy)       { Car.energies.keys.sample }
    sequence(:transmission) { Car.transmissions.keys.sample }
    sequence(:category)     { Car.categories.keys.sample }
    sequence(:mileage)      { Car.mileages.keys.sample }
    sequence(:description)  { Faker::Lorem.paragraph  }
    sequence(:price)        { rand(10..100)  }
    sequence(:doors)        { [3,5].sample  }
    user
  end
end
