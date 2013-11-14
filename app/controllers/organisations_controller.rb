class OrganisationsController < LoggedInUserRequiredController
  def index
    @invitations = InvitationsForUserQuery.new(current_user)
  end

  def new
    @organisation = Organisation.default
  end

  def create
    create_organisation = CreateOrganisation.new(params[:organisation], current_user)

    create_organisation.on(:success) do
      redirect_to organisations_path, notice: "You have successfully created an organisation."
    end

    create_organisation.on(:failure) do |organisation|
      @organisation = organisation
      render :new
    end

    create_organisation.create
  end
end
