require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  feature 'User' do

    scenario 'Sign up' do
      visit new_users_path

      user = FactoryBot.build(:user)
      
      fill_in 'user_first_name', with: user.first_name
      fill_in 'user_last_name', with: user.last_name
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      #fill_in 'user_password_confirmation', with: 'password'

      find("#new_user input[type='submit']").click

      last_user = User.last

      expect(last_user).to be_truthy
      expect(last_user.first_name).to eq(user.first_name)
      expect(last_user.last_name).to eq(user.last_name)
      expect(last_user.email).to eq(user.email)
    end
  end
end
