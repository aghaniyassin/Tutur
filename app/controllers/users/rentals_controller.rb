class Users::RentalsController < ApplicationController
  def index
    @rentals = current_user.cars_rentals.page(params[:page]).per(12)
  end

  def show
    @rental = current_user.cars_rentals.find params[:id]
  end

  def update
    @rental = current_user.cars_rentals.find params[:id]

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
end
