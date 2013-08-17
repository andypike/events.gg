require 'spec_helper'

describe "Show a list of games" do
  context "admin users have access" do
    before do
      create :game, name: "StarCraft 2"
      admin = create :admin
      login_as admin

      within main_menu do
        click_on "Admin"
      end

      click_on "1 Game"
    end

    it "shows the games list page" do
      page.should have_css("h1", text: "1 Game")
    end 

    it "lists the current games" do
      page.should have_css("table tbody td", text: "StarCraft 2")
    end
  end
end