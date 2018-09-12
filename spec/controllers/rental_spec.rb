require 'rails_helper'

RSpec.describe RentalsController do
  render_views
  let(:owner)         { FactoryBot.create(:user) }
  let(:tenant)        { FactoryBot.create(:user) }
  let(:car)           { FactoryBot.create(:car, user: owner) }
  let(:rental_params) { FactoryBot.attributes_for(:rental) }
  let(:rentals)       { FactoryBot.create_list(:rental, 5, car: car, user: tenant) }
  let(:rental)        { rentals.sample }

  describe 'SHOW /rentals' do
    it 'expect to show rental page' do
      get :new, params: { car_id: car.id }

      expect(response.body).to have_content(car.title)
    end
  end

  describe 'POST /rentals' do
    it 'expect to create rental' do
      sign_in! tenant

      expect do
        post :create, params: { car_id: car.id, rental: rental_params }
      end.to change(Rental, :count).by(1)
    end
  end

  describe 'POST /rentals' do
    it "expect to don't create a rental when a car is already rented" do
      rental = FactoryBot.create(:rental, status: true, car: car, user: tenant, start_at: 5.day.since, end_at: 10.day.since)
      sign_in! tenant

      rental_params = FactoryBot.attributes_for(:rental, car_id: car.id, start_at: 6.day.since, end_at: 8.day.since)

      expect do
        post :create, params: { car_id: car.id, rental: rental_params }
      end.to change(Rental, :count).by(0)
    end
  end

  describe 'GET /rentals/:id' do
    it 'expect to show rental' do
      sign_in! tenant
      get :show, params: { id: rental.id }

      expect(response).to render_template('rentals/show')
    end
  end

  describe 'GET /rentals' do
    it 'expect to renders rentals' do
      sign_in! tenant
      rentals
      get :index

      rentals.each do |rental|
        expect(response.body).to have_link(href: rental_path(rental))
      end
    end
  end

end
