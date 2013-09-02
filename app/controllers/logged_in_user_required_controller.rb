class LoggedInUserRequiredController < ApplicationController
  before_action :ensure_logged_in_user

  private
    def ensure_logged_in_user
      raise CanCan::AccessDenied.new("User is not logged in but is required") if current_user.nil?
    end
end