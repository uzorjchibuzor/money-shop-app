class ApplicationController < ActionController::Base
  def logged_in?
    redirect_to sign_in_path unless session[:username].present?
  end

  def current_user
    @current_user ||= User.find_by_username(session[:username])
  end

  helper_method :current_user
end
