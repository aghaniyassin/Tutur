module Helpers
  def sign_in!(user)
    controller.auto_login(user)
  end
end
