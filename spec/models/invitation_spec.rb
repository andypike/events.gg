require 'spec_helper'

describe Invitation do
  context "validates" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:organisation_id) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:status) }
    it { should allow_value("member").for(:role) }
    it { should allow_value("manager").for(:role) }
    it { should_not allow_value("god").for(:role) }
    it { should allow_value("accepted").for(:status) }
    it { should allow_value("pending").for(:status) }
    it { should allow_value("rejected").for(:status) }
    it { should_not allow_value("derp").for(:status) }
  end
end
