module SessionsHelper

  def signed_in_user?
    unless logged_in?
      flash_message :danger, 'Please sign up or sign in'
      session[:return_to] = request.url if request.get?
      redirect_to new_users_path
    end
  end

  def date_query
    session[:car_query].try(:[], 'rental')
  end

  def address_query
    session[:car_query].try('address')
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
end
