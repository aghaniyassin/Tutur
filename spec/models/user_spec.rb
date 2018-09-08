require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it "expect to have a unique email" do
    invalid_user = FactoryBot.build(:user)
    invalid_user.email = user.email

    expect(invalid_user).to be_invalid
  end

  it "expect to validated god email formats" do
    expect(user).to be_valid
  end

  it "expect to invalidated wrong email formats" do
    addresses = %w[test@test,com test.
                   @test.com test@ test@est..com]
    addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).to be_invalid
    end
  end

  it "expect to have 6 letters in the password" do
    1.upto(5) do |letter_count|
      user.password = Faker::Lorem.characters(letter_count)
      expect(user).to be_invalid
    end

    user.password = Faker::Lorem.characters(6)
    expect(user).to be_valid
  end

  it "expect to have a first name" do
    invalid_user = FactoryBot.build(:user)
    invalid_user.first_name = ''

    expect(invalid_user).to be_invalid
  end

  it "expect to have a last name" do
    invalid_user = FactoryBot.build(:user)
    invalid_user.last_name = ''

    expect(invalid_user).to be_invalid
  end
end
