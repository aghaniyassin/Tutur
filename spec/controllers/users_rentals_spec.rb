RSpec.describe Users::RentalsController do
  render_views
  let(:owner)         { FactoryBot.create(:user) }
  let(:tenant)        { FactoryBot.create(:user) }
  let(:car)           { FactoryBot.create(:car, user: owner) }
  let(:cars)          { FactoryBot.create_list(:car, 10, user: owner) }
  let(:rental_params) { FactoryBot.attributes_for(:rental) }
  let!(:rentals)      { FactoryBot.create_list(:rental, 5, car: car, user: tenant) }
  let(:rental)        { rentals.sample }

  describe 'GET /users/rentals' do
    it "expect to render user's rentals" do
      sign_in! owner
      rentals

      get :index

      rentals.each do |rental|
        expect(response.body).to have_link(href: user_rental_path(rental))
      end
    end
  end

  describe 'GET /rentals/:id' do
    it 'expect to show rental' do
      sign_in! owner
      get :show, params: { id: rental.id }

      expect(response).to render_template('users/rentals/show')
    end
  end

  describe 'PATCH /rentals/:id' do
    it 'expect to accept rental' do
      10.times do |t|
        FactoryBot.create(:rental, car: cars[t], user: tenant, start_at: 1.day.since, end_at: 10.day.since)
      end
      rental = cars.last.rentals.last
      sign_in! owner

      get :update, params: { id: rental.id, rental: { id: rental.id, status: true } }

      rental.reload
      expect(rental.status).to be_truthy
    end
  end
end
