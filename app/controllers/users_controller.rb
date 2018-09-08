class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      login(user_params[:email], user_params[:password])
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    current_user.update_attributes user_params

    redirect_to edit_user_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
