class CarsController < ApplicationController
  before_action :signed_in_user?, only: [:new, :create, :edit, :update, :delete]

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

  private
  def car_params
    params.require(:car).permit(:year, :brand, :model, :year, :energy, :doors,
                                :transmission, :category, :mileage, :price, :description)
  end
end
