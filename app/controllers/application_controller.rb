class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= SecurityService.current_user(session)
  end 
  helper_method :current_user
end
