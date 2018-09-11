require 'rails_helper'

RSpec.describe Car, type: :model do
  let(:owner) { FactoryBot.create(:user) }
  let!(:car)   { FactoryBot.create(:car, user: owner) }

  it "expect to have a description" do
    car.description = nil

    expect(car).to be_invalid
  end

  it "expect to have a brand" do
    car.brand = nil

    expect(car).to be_invalid
  end

  it "expect to have a model" do
    car.model = nil

    expect(car).to be_invalid
  end

  it "expect to have a price" do
    car.price = nil

    expect(car).to be_invalid
  end

  # Stub geocoder error
  # it "expect to have a street address" do
  #   car.street = nil
  #
  #   expect(car).to be_invalid
  # end
  #
  # it "expect to have a city" do
  #   car.city = nil
  #
  #   expect(car).to be_invalid
  # end
  #
  # it "expect to have a postal code" do
  #   car.postal_code = nil
  #
  #   expect(car).to be_invalid
  # end
end
