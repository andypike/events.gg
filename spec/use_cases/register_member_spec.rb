require "spec_helper"

describe RegisterMember do
  context ".register" do
    let(:user_params) { double.as_null_object }
    let(:user) { double.as_null_object }

    context "saving successful" do
      before do
        User.stub(:new) { user }
        user.stub(:save) { true }
        SecurityService.stub(:login)
      end

      it "creates and saves a new user and returns it" do
        user.should_receive(:save)
        described_class.register(user_params, {}).should == user
      end

      it "logs the user in" do
        SecurityService.should_receive(:login)
        described_class.register(user_params, {})
      end

      it "sets the user role to normal" do
        user.should_receive(:role=).with("normal")
        described_class.register(user_params, {})
      end
    end

    context "saving unsuccessful" do
      before do
        User.stub(:new) { user }
        user.stub(:save) { false }
      end

      it "doesn't logs the user in" do
        SecurityService.should_not_receive(:login)
        described_class.register(user_params, {})
      end
    end
  end
end
