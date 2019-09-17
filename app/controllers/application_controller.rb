class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if current_user.sign_in_count == 1
      edit_password_path current_user.id
    else
      root_path
    end
  end

end
