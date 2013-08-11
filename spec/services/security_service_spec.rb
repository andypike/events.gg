require 'spec_helper'

describe SecurityService do
  context ".login" do
    it "stores the user id in session" do
      user = stub(id: 1)
      session = {}

      SecurityService.login(user, session)
      session["user_id"].should == 1
    end
  end

  context ".logout" do
    it "clears the user id from the session" do
      session = {}
      SecurityService.logout(session)
      session["user_id"].should be_nil
    end
  end

  context ".current_user" do
    it "returns nil if the session does not contain a user id" do
      user = SecurityService.current_user({})
      user.should be_nil
    end

    it "finds a matching user based on id" do
      current_user = stub
      session = {"user_id" => 1}

      User.stub(:where) { [current_user] }
      user = SecurityService.current_user(session)
      user.should == current_user
    end

    it "retruns nil if no matching users found" do
      session = {"user_id" => 1}

      User.stub(:where) { [] }
      user = SecurityService.current_user(session)
      user.should be_nil
    end
  end

  context ".authenticate" do
    pending
  end
end
