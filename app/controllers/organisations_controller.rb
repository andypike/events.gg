class OrganisationsController < ApplicationController
  def index
    @invitations = InvitationsForUserQuery.new(current_user)
  end

  def new
    @organisation = Organisation.default
  end

  def create
    @organisation = OrganisationCreationService.create(organisation_params, current_user)

    if @organisation.valid?
      redirect_to organisations_path, notice: "You have successfully created an organisation."
    else
      render :new
    end
  end

  private
    def organisation_params
      params.require(:organisation).permit(:name, :logo)
    end
end