class SessionsController < ApplicationController
  def destroy
    logout
    redirect_to root_path
  end

  def create
    if login(session_params[:email], session_params[:password])
      redirect_to root_path
    else
      render :new
    end
  end

  def new
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
