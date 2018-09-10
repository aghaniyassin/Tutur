RSpec.describe Users::RentalsController do
  render_views
  let(:owner)         { FactoryBot.create(:user) }
  let(:tenant)        { FactoryBot.create(:user) }
  let(:car)           { FactoryBot.create(:car, user: owner) }
  let(:rental_params) { FactoryBot.attributes_for(:rental) }
  let!(:rentals)       { FactoryBot.create_list(:rental, 5, car: car, user: tenant) }
  let(:rental)        { rentals.sample }

  describe 'GET /users/rentals' do
    it "expect to render user's rentals" do
      sign_in! owner
      rentals

      get :index

      rentals.each do |rental|
        expect(response.body).to have_link(href: rental_path(rental))
      end
    end
  end
end
