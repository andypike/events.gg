class Admin::BaseController < ApplicationController
  before_action :verify_admin

  private
    def verify_admin
      raise CanCan::AccessDenied unless current_user.try(:admin?)
    end
end