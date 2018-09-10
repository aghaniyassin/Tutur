class Users::RentalsController < ApplicationController
  def index
    @rentals = Rental.joins(:car).where('cars.user_id = ?', current_user.id)
                                 .page(params[:page]).per(12)
  end
end
