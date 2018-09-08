require 'rails_helper'

RSpec.describe SessionsController do
  describe 'DELETE /sessions' do
    it 'expect to sign out' do
      user = FactoryBot.create(:user)
      controller.auto_login(user)

      expect(assigns(:current_user)).to eq(user)
      delete :destroy
      expect(assigns(:current_user)).to be_falsy
    end
  end

  describe 'POST /sessions' do
    it 'expect to sign int' do
      user_params = FactoryBot.attributes_for(:user)
      user = User.create user_params

      expect(assigns(:current_user)).to be_falsy

      post :create, params: { session: { email: user_params[:email], password: user_params[:password] } }
      expect(assigns(:current_user)).to eq(user)
    end
  end
end
