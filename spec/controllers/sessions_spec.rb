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
end
