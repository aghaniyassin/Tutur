require 'rails_helper'

RSpec.describe Rental, type: :model do
  let(:owner)         { FactoryBot.create(:user) }
  let(:tenant)        { FactoryBot.create(:user) }
  let(:car)           { FactoryBot.create(:car, user: owner) }
  let(:rentals)       { FactoryBot.create_list(:rental, 5, car: car, user: tenant) }

  it "expect to compute amount" do
    rental = FactoryBot.create(:rental, start_at: 1.day.since, end_at: 11.day.since)

    rental.reload
    expect(rental.amount).to be(rental.car.price * 10)
  end

  it "expect to have start date" do
    rental = FactoryBot.build(:rental, start_at: nil)

    expect(rental).to be_invalid
  end

  it "expect to have end date" do
    rental = FactoryBot.build(:rental, end_at: nil)

    expect(rental).to be_invalid
  end

  it "expect to have start in future" do
    rental = FactoryBot.build(:rental, start_at: 1.day.ago)

    expect(rental).to be_invalid
  end

  it "expect to have end date in future" do
    rental = FactoryBot.build(:rental, end_at: 1.day.ago)

    expect(rental).to be_invalid
  end

  it "expect to return all user's rentals" do
    expect(owner.cars_rentals).to eq(rentals)
  end
end
