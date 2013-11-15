require "spec_helper"

describe SecurityService do
  context ".login" do
    it "stores the user id in session" do
      user = User.new(id: 1)
      session = {}

      SecurityService.login(user, session)
      session["user_id"].should == 1
    end
  end

  context ".logout" do
    it "clears the user id from the session" do
      session = { "user_id" => 1 }
      SecurityService.logout(session)
      session["user_id"].should be_nil
    end
  end

  context ".current_user" do
    let(:current_user) { create :user }

    it "returns nil if the session does not contain a user id" do
      SecurityService.current_user({}).should be_nil
    end

    it "finds a matching user based on id" do
      session = { "user_id" => current_user.id }
      SecurityService.current_user(session).should == current_user
    end

    it "retruns nil if no matching users found" do
      session = { "user_id" => -1 }
      SecurityService.current_user(session).should be_nil
    end
  end

  context ".authenticate" do
    let(:params) { { email: "a@b.com", password: "secret" } }
    let(:session) { fake }

    context "when authentication fails" do
      it "returns nil if no user has the supplied email" do
        SecurityService.authenticate(params.merge(email: "c@d.com"), session).should be_nil
      end

      it "returns nil if a user is found by email but the password doesn't match" do
        SecurityService.authenticate(params, session).should be_nil
      end
    end

    context "when authentication succeeds" do
      let!(:current_user) { create :user, email: "a@b.com" }

      before do
        SecurityService.stub(:login)
      end

      it "authenticates the matching user and returns it if vaild" do
        SecurityService.authenticate(params, session).should == current_user
      end

      it "logs in the user if it authenticates" do
        SecurityService.authenticate(params, session)
        expect(SecurityService).to have_received(:login)
      end
    end
  end
end
