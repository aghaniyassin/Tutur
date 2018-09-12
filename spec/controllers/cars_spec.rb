require 'rails_helper'

RSpec.describe CarsController do
  include ActionDispatch::TestProcess

  render_views
  let(:car)           { FactoryBot.create(:car) }
  let(:user)          { FactoryBot.create(:user) }
  let(:car_params)    { FactoryBot.attributes_for(:car) }
  let(:owner)         { FactoryBot.create(:user) }
  let(:tenant)        { FactoryBot.create(:user) }
  let(:cars)          { FactoryBot.create_list(:car, 10, user: owner) }

  describe 'POST /cars' do
    it 'expect to create car' do
      sign_in! user

      expect do
        post :create, params: { car: car_params }
      end.to change(Car, :count).by(1)
    end
  end

  describe 'GET /cars/:id' do
    it 'expect to render car view' do
      get :show, params: { id: car.id }

      expect(response).to render_template('cars/show')
    end
  end

  describe 'PATCH /cars/:id' do
    it 'expect to update car' do
      sign_in! car.user

      stub = Car.new car_params
      stub.assign_attributes latitude: car.latitude, longitude: car.longitude
      Helpers.stub_with(stub)

      patch :update, params: { id: car.id, car: car_params }

      car.reload
      car_params.except! :latitude, :longitude
      expect(car.attributes.symbolize_keys).to include(car_params)
    end
  end

  describe 'GET /cars' do
    it 'expect to show cars' do
      cars = FactoryBot.create_list(:car, 10)

      get :index

      cars.each do |car|
        expect(response.body).to have_link(href: car_path(car))
      end
    end
  end

  describe 'GET /cars' do
    it 'expect to renders Renault cars' do
      cars = FactoryBot.create_list(:car, 10)
      brand = 'renault'

      get :index, params: { car: { brand: brand }}
      renault_cars = cars.select { |c| c[:brand] == brand }

      expect(assigns(:cars)).to eq(renault_cars)
    end
  end

  describe 'GET /cars' do
    it 'expect to renders available cars' do
      10.times do |t|
        FactoryBot.create(:rental, car: cars[t], user: tenant, start_at: (t+1).day.since, end_at: (t+2).day.since, status: true)
      end

      get :index, params: { car: { rental: { start_at: 5.day.since, end_at: 9.day.since }}}

      expect(assigns(:cars).size).to eq(5)
    end
  end

  describe 'GET /cars' do
    it 'expect to renders cars with rentals not yet accepted' do
      10.times do |t|
        FactoryBot.create(:rental, car: cars[t], user: tenant, start_at: 1.day.since, end_at: 10.day.since)
      end
      rental = cars.last.rentals.last
      rental.update_attributes status: true

      get :index, params: { car: { rental: { start_at: 1.day.since, end_at: 10.day.since }}}

      expect(assigns(:cars).size).to eq(9)
    end
  end

  describe 'GET /cars' do
    it 'expect to renders cars near Paris' do
      cars = ['Paris', 'Lyon', 'Lille'].map do |city|
        car = FactoryBot.create(:car, user: owner, city: city)
        Helpers.stub_with(car)
        car
      end

      get :index, params: { car: { address: cars.first.address }}

      expect(assigns(:cars).size).to eq(1)
    end
  end

  describe 'GET /cars' do
    it 'expect to renders car image' do
      stub = Car.new car_params
      Helpers.stub_with(stub)

      sign_in! user
      path = './spec/fixtures/images/car.jpg'
      image = Rack::Test::UploadedFile.new(path, 'application/jpeg', true)
      car_params.merge! image: image

      post :create, params: { car: car_params }

      expect(assigns(:car).image.attached?).to be_truthy
    end
  end

  describe 'PATCH /cars/:id' do
    it 'expect to redirect if user want to edit a car that belongs to another' do
      sign_in! user

      patch :update, params: { id: car.id, car: car_params }

      expect(response.location).to eq(root_url)
    end
  end
end
