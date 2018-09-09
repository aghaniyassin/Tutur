require 'rails_helper'

RSpec.describe UsersController do
  render_views
  let(:user) { FactoryBot.create(:user) }
  let(:user_params) { FactoryBot.attributes_for(:user) }

  describe 'POST /users' do
    it 'expect to create user' do
      sign_in! user

      expect do
        post :create, params: { user: user_params }
      end.to change(User, :count).by(1)
    end
  end

  describe 'PATCH /users' do
    it 'expect to render car view' do
      sign_in! user
      patch :update, params: { user: user_params }

      user.reload
      expect(assigns(:current_user)).to eq(user)
    end
  end
end
