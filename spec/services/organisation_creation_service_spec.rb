require 'spec_helper'

describe OrganisationCreationService do
  context ".create" do
    let(:organisation_params) { stub.as_null_object }
    let(:user) { mock_model("User").as_null_object }
    let(:organisation) { mock_model("Organisation").as_null_object }
    let(:invitation) { mock_model("Invitation").as_null_object }

    context "saving successful" do
      before do
        Organisation.stub(:new) { organisation }
        organisation.stub(:save) { true }
      end

      it "creates and saves a new organisation and returns it" do
        organisation.should_receive(:save)
        OrganisationCreationService.create(organisation_params, user).should == organisation
      end

      it "sets the organisation status to pending approval" do
        organisation.should_receive(:status=).with('pending_approval')
        OrganisationCreationService.create(organisation_params, user)
      end

      it "joins the user and the organisation" do
        Invitation.should_receive(:create).with(organisation: organisation, user: user, role: 'manager', status: 'accepted') { invitation }
        OrganisationCreationService.create(organisation_params, user)
      end
    end

    context "saving unsuccessful" do 
      before do
        Organisation.stub(:new) { organisation }
        organisation.stub(:save) { false }
      end

      it "doesn't join the user and the organisation" do
        Invitation.should_not_receive(:create)
        OrganisationCreationService.create(organisation_params, user)
      end
    end
  end
end