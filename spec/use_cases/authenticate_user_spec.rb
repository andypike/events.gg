require "spec_helper"

describe AuthenticateUser do
  let!(:current_user) { create :user, email: "a@b.com" }
  let(:params) { { email: "a@b.com", password: "secret" } }
  let(:session) { fake }
  let(:listener) { fake }

  describe ".authenticate" do
    before do
      SecurityService.stub(:login)
      subject.subscribe(listener)
      subject.authenticate
    end

    context "with valid credentials" do
      subject { AuthenticateUser.new(session, params) }

      it "logs in the user if it authenticates" do
        expect(SecurityService).to have_received(:login)
      end

      it "publishes a success event" do
        expect(listener).to have_received(:success).with(current_user)
      end
    end

    context "with invalid email" do
      subject { AuthenticateUser.new(session, params.merge(email: "c@d.com")) }

      it "publishes a failure event" do
        expect(listener).to have_received(:failure)
      end
    end

    context "with invalid password" do
      subject { AuthenticateUser.new(session, params.merge(password: "incorrect")) }

      it "publishes a failure event" do
        expect(listener).to have_received(:failure)
      end
    end
  end
end
