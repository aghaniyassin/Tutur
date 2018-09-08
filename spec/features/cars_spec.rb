require 'rails_helper'

RSpec.feature 'Cars', type: :feature do
  def login
    user_params = FactoryBot.attributes_for(:user)
    user = User.create user_params

    visit new_sessions_path
    fill_in 'session_email', with: user_params[:email]
    fill_in 'session_password', with: user_params[:password]

    find('.sign-in-button').click

    user
  end

  describe 'POST /cars' do

    scenario 'expect to sign up' do
      login
      visit new_car_path

      car_params = FactoryBot.attributes_for(:car)

      attributes_by_field = {
        select:   [:brand, :model, :energy, :transmission,
                   :category, :year, :mileage, :doors],
        standard: [:description, :price]
      }

      attributes_by_field[:select].each do |attribute|
        find("#car_#{attribute} option[value='#{car_params[attribute]}']").select_option
      end

      attributes_by_field[:standard].each do |attribute|
        fill_in "car_#{attribute}", with: car_params[attribute]
      end


      find(".submit-new-car").click
      car = Car.last

      attributes = attributes_by_field.map {|a, b| b}.flatten

      attributes.each do |attribute|
        expect(car[attribute]).to eq(car_params[attribute])
      end
    end
  end

  describe 'GET /cars/:id' do

    scenario 'expect to show car page' do
      user = FactoryBot.create(:user)
      car = user.cars.build
      car.update_attributes FactoryBot.attributes_for(:car)

      visit car_path(car)

      expect(page).to have_content(car.year)
      expect(page).to have_content(car.brand.humanize)
      expect(page).to have_content(car.model.humanize)
    end
  end
end
