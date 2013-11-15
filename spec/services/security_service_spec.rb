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
end
