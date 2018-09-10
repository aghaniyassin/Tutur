require 'rails_helper'

RSpec.describe RentalsController do
  render_views
  let(:owner) { FactoryBot.create(:user) }
  let(:tenant) { FactoryBot.create(:user) }
  let(:car) { FactoryBot.create(:car, user: owner) }
  let(:rental_params) { FactoryBot.attributes_for(:rental) }

  describe 'SHOW /rental' do
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
end
