class ApplicationController < ActionController::Base
before_action :authenticate_user!

  def after_sign_in_path_for(user)
    user_contents_path(user)
  end

  def after_sign_out_path_for(user)
    new_user_session_path
  end
end
