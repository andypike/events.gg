class OrganisationsController < ApplicationController
  def index
    @invitations = InvitationsForUserQuery.new(current_user)
  end

  def new
    @organisation = Organisation.default
  end

  def create
    
  end
end