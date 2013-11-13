class Admin::OrganisationsController < Admin::BaseController
  def index
    @organisations = AllOrganisationsQuery.new
  end

  def new
    @organisation = Organisation.default
  end

  def create
    @organisation = Organisation.new(organisation_params)

    if @organisation.save
      redirect_to admin_organisations_path, notice: "The organisation was successfully added"
    else
      render :new
    end
  end

  def edit
    @organisation = Organisation.find(params[:id])
  end

  def update
    @organisation = Organisation.find(params[:id])

    if @organisation.update_attributes(organisation_params)
      redirect_to admin_organisations_path, notice: "The organisation was successfully updated"
    else
      render :edit
    end
  end

  private

    def organisation_params
      params.require(:organisation).permit(:name, :status, :logo)
    end
end
