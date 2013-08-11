require 'spec_helper'

describe RegistrationService do
  context ".register" do
    let(:user_params) { stub.as_null_object }
    let(:user) { stub }

    it "creates and saves a new user and returns it" do
      User.stub(:new) { user }
      user.should_receive(:save)
      RegistrationService.register(user_params, {}).should == user
    end

    it "logs the user in if the save is successful" do
      User.stub(:new) { user }
      user.stub(:save) { true }
      SecurityService.should_receive(:login)
      RegistrationService.register(user_params, {})
    end

    it "doesn't logs the user in if the save fails" do
      User.stub(:new) { user }
      user.stub(:save) { false }
      SecurityService.should_not_receive(:login)
      RegistrationService.register(user_params, {})
    end
  end
end