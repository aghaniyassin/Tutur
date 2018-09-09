class Users::CarsController < ApplicationController
  def index
    @cars = current_user.cars.page(params[:page]).per(12)
  end
end
