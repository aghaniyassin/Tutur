require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  describe 'GET /' do
    it 'renders the home page' do
      get root_path
      expect(response).to render_template('pages/home')
    end
  end
end
