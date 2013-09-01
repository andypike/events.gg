require 'spec_helper'

describe Organisation do
  context "validates" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:status) }
    it { should allow_value("pending_approval").for(:status) }
    it { should allow_value("approved").for(:status) }
    it { should allow_value("rejected").for(:status) }
    it { should_not allow_value("derp").for(:status) }
  end
end
