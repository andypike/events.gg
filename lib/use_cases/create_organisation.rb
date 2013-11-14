class CreateOrganisation
  include Wisper::Publisher

  def initialize(params, manager)
    @params = secure_params(params)
    @manager = manager
  end

  def create
    org = Organisation.new(@params)
    org.status = "pending_approval"

    if org.save
      Invitation.create(organisation: org, user: @manager, role: "manager", status: "accepted")
      publish :success, org
    else
      publish :failure, org
    end
  end

  private

    def secure_params(params)
      ActionController::Parameters.new(params).permit(:name, :logo)
    end
end
