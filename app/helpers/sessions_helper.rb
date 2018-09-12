module SessionsHelper

  def signed_in_user?
    unless logged_in?
      flash_message :danger, 'Please sign up or sign in'
      redirect_to new_users_path
    end
  end

  def date_query
    session[:car_query].try(:[], 'rental')
  end

  def address_query
    session[:car_query].try('address')
  end
end
