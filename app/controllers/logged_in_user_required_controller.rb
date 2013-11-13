class LoggedInUserRequiredController < ApplicationController
  before_action :ensure_logged_in_user

  private

    def ensure_logged_in_user
      fail CanCan::AccessDenied, "User is not logged in but is required" if current_user.nil?
    end
end
