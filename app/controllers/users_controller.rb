class UsersController < ApplicationController
  before_action :signed_in_user?, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      login(user_params[:email], user_params[:password])
      flash_message :success, "Congratulations #{@user.first_name}, you have created a Tutur account!"
      redirect_to root_path
    else
      @user.errors.full_messages.map { |m| flash_message :danger, m }
      render :new
    end
  end

  def edit
  end

  def update
    unless current_user.update_attributes user_params
      current_user.errors.full_messages.map { |m| flash_message :danger, m }
    else
      flash_message :success, 'Profile updated'
    end

    render :edit
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password).reject{|_, v| v.blank?}
  end
end
