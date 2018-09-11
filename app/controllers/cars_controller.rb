class CarsController < ApplicationController
  before_action :signed_in_user?, only: [:new, :create, :edit, :update, :delete]
  before_action :find_current_user_car, only: [:edit, :update]

  def new
    @car = current_user.cars.build
  end

  def create
    @car = current_user.cars.build car_params
    if @car.save
      flash_message :success, "Congratulations #{current_user.first_name}, you have register your car!"
      redirect_to root_path
    else
      @car.errors.full_messages.map { |m| flash_message :danger, m }
      render :new
    end
  end

  def show
    @car = Car.find params[:id]
  end

  def edit
  end

  def update
    if @car.update_attributes(car_params)
      flash_message :success, 'Car information updated'
      redirect_to @car
    else
       @car.errors.full_messages.map { |m| flash_message :danger, m }
       render :edit
    end
  end

  def index
    @cars = Car.available_between(date_params)
               .where(car_params).page(params[:page]).per(12)
    @car = Car.new
    @car.rentals.build
  end

  private
  def car_params
    if params.has_key?(:car)
      params.require(:car).permit(:year, :brand, :model, :year, :energy, :doors,
                                  :transmission, :category, :mileage, :price, :description).reject{|_, v| v.blank?}
    end
  end

  def date_params
    if params.has_key?(:car)
      rental_params = params.require(:car).permit(rental: [:start_at, :end_at])[:rental]

      rental = Rental.new rental_params
      return nil unless rental.start_at && rental.end_at

      if rental.valid_dates?
        rental.attributes.symbolize_keys.slice :start_at, :end_at
      else
        flash_message :danger, Rental::ERROR_DATE_MESSAGE
        nil
      end
    end
  end

  def find_current_user_car
    @car = current_user.cars.find params[:id]
  end
end
