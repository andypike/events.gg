require "spec_helper"

describe RegisterMember do
  let(:listener) { double.as_null_object }
  let(:params) { attributes_for(:user) }
  let(:session_store) { double }

  describe "#register" do
    before do
      SecurityService.stub(:login)
      subject.subscribe(listener)
      subject.register
    end

    context "with valid attributes" do
      subject { RegisterMember.new(params, session_store) }

      it "creates the user as a normal member" do
        User.first.normal?.should be_true
      end

      it "logs the user in" do
        expect(SecurityService).to have_received(:login)
      end

      it "publishes a success event" do
        expect(listener).to have_received(:success)
      end
    end

    context "with invalid attributes" do
      subject { RegisterMember.new(params.except(:name), session_store) }

      it "does not create the user" do
        User.count.should == 0
      end

      it "doesn't logs the user in" do
        expect(SecurityService).to_not have_received(:login)
      end
    end
  end
end
