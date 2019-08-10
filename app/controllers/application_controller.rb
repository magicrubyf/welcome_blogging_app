class ApplicationController < ActionController::Base

helper_method :current_user, :graph, :logged_in?




  private

  def current_user
    @current_user ||= User.find_by(uid: session[:user_info]['uid']) if session[:user_info]
  end

  def logged_in?
      !!current_user
  end

end
