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
      visit new_cars_path

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
      #expect(car.year).to eq(car_params[:year])
    end
  end
end
