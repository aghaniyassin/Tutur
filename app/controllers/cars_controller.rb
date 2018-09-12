class CarsController < ApplicationController
  before_action :signed_in_user?, only: [:new, :create, :edit, :update, :delete]
  before_action :find_current_user_car, only: [:edit, :update]
  before_action :store_query, only: [:index]

  def new
    @car = current_user.cars.build
  end

  def create
    @car = current_user.cars.build car_params
    if @car.save
      flash_message :success, "Congratulations #{current_user.first_name}, you have register your car!"
      redirect_to @car
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
    if location_params.try(:has_key?, :address)
      begin
        @cars = Car.near(location_params[:address], location_params[:radius] || 5)
      rescue
        flash_message :danger, 'Unknow address'
      end
    end

    @cars = (@cars || Car).available_between(date_params)
               .where(car_params).page(params[:page]).per(12)

    @car = Car.new car_params
    @rental = Rental.new date_params
  end

  private

  def all_params
    if params.has_key?(:car)
      params.require(:car).permit(:year, :brand, :model, :year, :energy, :doors,
                                  :transmission, :category, :mileage, :price, :description,
                                  :street, :city, :postal_code, :image,
                                  :address, :radius, rental: [:start_at, :end_at])
                                  .reject{|_, v| v.blank?}.to_h
    end
  end

  def query_params
    all_params || session[:car_query]
  end

  def location_params
    query_params.try :slice, 'address', 'radius'
  end

  def car_params
    query_params.try :except, 'address', 'radius', 'rental'
  end

  def date_params
    filtered_params = query_params.try(:[], 'rental')
                                  .try(:reject) {|_, v| v.blank?}

    if filtered_params && filtered_params.size <= 2
      rental = Rental.new filtered_params
      return nil unless rental.valid_dates?
      rental.attributes.symbolize_keys.slice :start_at, :end_at
    else
      nil
    end
  end

  def find_current_user_car
    unless @car = current_user.cars.find_by(id: params[:id])
      flash_message :danger, 'You are not authorized to do this action'
      redirect_to root_path
    end
  end

  def store_query
    session[:car_query] = all_params if all_params
  end
end
