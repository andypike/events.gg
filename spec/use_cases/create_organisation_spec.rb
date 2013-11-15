require "spec_helper"

describe CreateOrganisation do
  let(:listener) { fake }
  let(:manager) { create :user }
  let(:params) { attributes_for(:organisation) }

  describe "#create" do
    before do
      subject.subscribe(listener)
      subject.create
    end

    context "with valid attributes" do
      subject { CreateOrganisation.new(params, manager) }

      it "creates the organisation pending approval" do
        Organisation.first.pending_approval?.should be_true
      end

      it "invites the user as a manager of the organisation" do
        invitation = manager.invitations.first
        invitation.manager?.should be_true
        invitation.accepted?.should be_true
      end

      it "publishes a success event" do
        expect(listener).to have_received(:success)
      end
    end

    context "with invalid attributes" do
      subject { CreateOrganisation.new(params.except(:name), manager) }

      it "does not create the organisation" do
        Organisation.count.should == 0
      end

      it "publishes a failure event" do
        expect(listener).to have_received(:failure)
      end
    end

  end
end
