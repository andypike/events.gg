require "spec_helper"

describe Game do
  context "validates" do
    it { should validate_presence_of(:name) }
    it { should allow_value("active").for(:status) }
    it { should allow_value("suggestion").for(:status) }
    it { should_not allow_value("blah").for(:status) }
  end
end
