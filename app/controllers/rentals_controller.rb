class RentalsController < ApplicationController
  before_action :find_car, only: [:new]
  before_action :signed_in_user?, only: [:create, :index, :show]

  def new
    @rental = @car.rentals.build date_query
  end

  def create
    @rental = current_user.rentals.build rental_params
    if @rental.save
      flash_message :success, 'Your rental request is registered!'
      redirect_to @rental
    else
      @rental.errors.full_messages.map { |m| flash_message :danger, m }
      render :new
    end
  end

  def show
    unless @rental = current_user.rentals.find_by(id: params[:id])
      flash_message :danger, 'You are not authorized to do this action'
      redirect_to root_path
    end
  end

  def index
    @rentals = current_user.rentals.order(created_at: :desc)
                           .page(params[:page]).per(12)
  end

  private

  def rental_params
    params.require(:rental).permit(:start_at, :end_at).merge(car_id: params[:car_id])
  end

  def find_car
    @car = Car.find(params[:car_id])
  end
end
