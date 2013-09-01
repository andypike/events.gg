class OrganisationCreationService
  def self.create(organisation_params, user)
    organisation = Organisation.new(organisation_params)
    organisation.status = "pending_approval"

    if organisation.save
      Invitation.create(organisation: organisation, user: user, role: 'manager', status: 'accepted')
    end

    organisation
  end
end