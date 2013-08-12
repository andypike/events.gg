class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: "You do not have permission to access that page"
  end

  private
    def current_user
      @current_user ||= SecurityService.current_user(session)
    end 
    helper_method :current_user
end
