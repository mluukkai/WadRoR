class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def current_user
    return User.find(session[:user_id]) if session[:user_id]
    nil
  end
end
