class Admin::BaseController < ApplicationController
  before_action :verify_admin

  private

    def verify_admin
      fail CanCan::AccessDenied unless current_user.try(:admin?)
    end
end
