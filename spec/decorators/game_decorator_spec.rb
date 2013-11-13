require "spec_helper"

describe GameDecorator do
  context "#number_of_followers" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:game) { create(:game) }
    subject { GameDecorator.new(game).number_of_followers }

    before do
      game.users << user1
    end

    it "returns the number of users that follow a game" do
      should eq 1
    end
  end
end
