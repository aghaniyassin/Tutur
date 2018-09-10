module SessionsHelper

  def signed_in_user?
    unless logged_in?
      flash_message :danger, 'Please sign up or sign in'
      redirect_to new_users_path
    end
  end
end
