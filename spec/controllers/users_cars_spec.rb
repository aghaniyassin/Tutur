require 'rails_helper'

RSpec.describe Users::CarsController do
  render_views
  let(:car) { FactoryBot.create(:car) }
  let(:user) { FactoryBot.create(:user) }
  let(:car_params) { FactoryBot.attributes_for(:car) }

  describe 'GET /users/cars' do
    it "expect to render user's car" do
      sign_in! user
      cars = FactoryBot.create_list(:car, 10, user: user)

      get :index

      cars.each do |car|
        expect(response.body).to have_link(href: edit_car_path(car))
      end
    end
  end
end
