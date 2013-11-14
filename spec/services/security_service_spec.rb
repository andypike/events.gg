require "spec_helper"

describe SecurityService do
  context ".login" do
    it "stores the user id in session" do
      user = double(id: 1)
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
      current_user = double
      session = { "user_id" => 1 }

      User.stub(:where) { [current_user] }
      user = SecurityService.current_user(session)
      user.should == current_user
    end

    it "retruns nil if no matching users found" do
      session = { "user_id" => 1 }

      User.stub(:where) { [] }
      user = SecurityService.current_user(session)
      user.should be_nil
    end
  end

  context ".authenticate" do
    let(:session_params) { { email: "a@b.com", password: "secret" } }
    let(:current_user) { double.as_null_object }
    let(:session) { double.as_null_object }

    it "returns nil if no user has the supplied email" do
      User.stub(:find_by) { nil }
      user = SecurityService.authenticate(session_params, session)
      user.should be_nil
    end

    it "authenticates the matching user and returns it if vaild" do
      User.stub(:find_by) { current_user }
      current_user.stub(:authenticate) { true }
      user = SecurityService.authenticate(session_params, session)
      user.should == current_user
    end

    it "authenticates the matching user and returns nil if not valid" do
      User.stub(:find_by) { current_user }
      current_user.stub(:authenticate) { false }
      user = SecurityService.authenticate(session_params, session)
      user.should be_nil
    end

    it "logs in the user if it authenticates" do
      User.stub(:find_by) { current_user }
      current_user.stub(:authenticate) { true }
      SecurityService.should_receive(:login).with(current_user, session)
      SecurityService.authenticate(session_params, session)
    end
  end
end
