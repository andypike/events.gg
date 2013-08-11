require 'spec_helper'

describe User do
  context "validating" do
    let(:existing_user) { User.new(name: 'Andy', password: 'whatever', password_confirmation: 'whatever', email: 'a@b.com', time_zone: "London").save!(validate: false) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:time_zone) }
    it { should ensure_length_of(:password).is_at_least(6) }
    it { should allow_value("someone@somewhere.com").for(:email) }
    it { should_not allow_value("blah").for(:email).with_message(/is not formatted properly/) }
    it { 
      existing_user
      should validate_uniqueness_of(:email).case_insensitive 
    }
  end
end
