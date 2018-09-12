class Users::RentalsController < ApplicationController
  before_action :find_owner_rentals, only: [:show, :update]

  def index
    @rentals = current_user.cars_rentals.order(created_at: :desc)
                           .page(params[:page]).per(12)
  end

  def show
  end

  def update
    if @rental.update_attributes rental_params
      flash_message :success, 'Your rental was modified!'
      redirect_to user_rental_path(@rental)
    else
      @rental.errors.full_messages.map { |m| flash_message :danger, m }
      render :show
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:start_at, :end_at, :status)
  end

  def find_owner_rentals
    unless @rental = current_user.cars_rentals.find_by(id: params[:id])
      flash_message :danger, 'You are not authorized to do this action'
      redirect_to root_path
    end
  end
end
