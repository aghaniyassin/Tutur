require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  def login
    user_params = FactoryBot.attributes_for(:user)
    user = User.create user_params

    visit new_sessions_path
    fill_in 'session_email', with: user_params[:email]
    fill_in 'session_password', with: user_params[:password]

    find('.sign-in-button').click

    user
  end

  describe 'POST /users' do

    scenario 'expect to sign up' do
      visit new_users_path

      user = FactoryBot.build(:user)

      fill_in 'user_first_name', with: user.first_name
      fill_in 'user_last_name', with: user.last_name
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      #fill_in 'user_password_confirmation', with: 'password'

      find(".submit-new-user").click

      last_user = User.last

      expect(last_user).to be_truthy
      expect(last_user.first_name).to eq(user.first_name)
      expect(last_user.last_name).to eq(user.last_name)
      expect(last_user.email).to eq(user.email)
    end
  end

  describe 'PATCH /user' do

    scenario 'expect to update current user' do
      user = login
      visit edit_user_path

      first_name = Faker::Name.first_name
      fill_in 'user_first_name', with: first_name

      find(".submit-user-edit").click

      expect(User.last.first_name).to eq(first_name)
    end

    scenario 'expect to redirect if no user connected' do
      visit edit_user_path

      expect(page).to have_current_path(new_users_path)
    end
  end
end
