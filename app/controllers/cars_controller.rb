class CarsController < ApplicationController
  before_action :signed_in_user?, only: [:new, :create, :edit, :update, :delete]
  before_action :find_current_user_car, only: [:edit, :update]
  #before_action :redirect_if_not_owner!, only: [:update]

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

  private
  def car_params
    params.require(:car).permit(:year, :brand, :model, :year, :energy, :doors,
                                :transmission, :category, :mileage, :price, :description)
  end

  def find_current_user_car
    @car = current_user.cars.find params[:id]
  end
end
