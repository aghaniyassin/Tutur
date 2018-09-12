# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

address = [
  { street: '10 rue de paris', city: 'Créteil', postal_code: 94000 },
  { street: '10 rue du maroc', city: 'Paris', postal_code: 75001 },
  { street: '10 rue victor hugo', city: 'Lyon', postal_code: 69001 },
  { street: '10 rue solferino', city: 'Lille', postal_code: 59000 },
  { street: '10 rue de rome', city: 'Marseille', postal_code: 13010 },
  { street: '10 rue de la liberté', city: 'dijon', postal_code: 21000 },
]

20.times do |t|
  owner = FactoryBot.create(:user, email: "owner#{t}@test.com", password: 'sesame')
  FactoryBot.create(:user, email: "tenant#{t}@test.com", password: 'sesame')

  car_params = { brand:        Car.brands.keys.sample,
                 model:        Car.models.keys.sample,
                 year:         rand(2000..Time.now.year),
                 energy:       Car.energies.keys.sample,
                 transmission: Car.transmissions.keys.sample,
                 category:     Car.categories.keys.sample,
                 mileage:      Car.mileages.keys.sample,
                 description:  Faker::Lorem.paragraph,
                 price:        rand(10..100),
                 doors:        [3,5].sample }

  car_params = car_params.merge(address.sample)
                         .merge(user: owner)
  Car.create(car_params)
end
