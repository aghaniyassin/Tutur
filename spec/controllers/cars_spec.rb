require 'rails_helper'

RSpec.describe CarsController do
  let(:car) { FactoryBot.create(:car) }
  let(:user) { FactoryBot.create(:user) }
  let(:car_params) { FactoryBot.attributes_for(:car) }

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
      patch :update, params: { id: car.id, car: car_params }

      car.reload
      expect(car.attributes.symbolize_keys).to include(car_params)
    end
  end
end
