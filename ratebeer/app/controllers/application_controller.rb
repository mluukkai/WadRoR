class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :currently_signed_in?, :current_user_admin?

  def current_user
    return User.find(session[:user_id]) if session[:user_id]
    nil
  end

  def current_user_admin?
    not current_user.nil? and current_user.admin?
  end

  def currently_signed_in?(user)
    current_user == user
  end

  def authenticate
    redirect_to signin_path, :notice => 'you should be signed in' if current_user.nil?
  end

end
