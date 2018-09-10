class RentalsController < ApplicationController
  before_action :find_car, only: [:new]

  def new
    @rental = @car.rentals.build
  end

  def create
    @rental = current_user.rentals.build rental_params
    if @rental.save
      flash_message :success, 'Your rental request is registered!'
      redirect_to @rental.car
    else
      @rental.errors.full_messages.map { |m| flash_message :danger, m }
      render :new
    end
  end

  def show
    @rental = current_user.rentals.find params[:id]
  end

  def index
    @rentals = current_user.rentals.page(params[:page]).per(12)
  end

  private

  def rental_params
    params.require(:rental).permit(:start_at, :end_at).merge(car_id: params[:car_id])
  end

  def find_car
    @car = Car.find(params[:car_id])
  end
end
