require 'spec_helper'

describe "Edit a game" do
  context "admin users have access" do
    before do
      create :game, name: "StarCraft 2"
      admin = create :admin
      login_as admin

      within main_menu do
        click_on "Admin"
      end

      click_on "1 Game"
      click_on "Edit"
    end

    it "shows the edit game page" do
      page.should have_content "Editing StarCraft 2"
    end 

    it "shows a populated form" do
      page.should have_field('Name', with: "StarCraft 2")
      page.should have_select('Status', selected: "Active")
      page.should have_button('Save changes')
    end

    it "updates the game if valid data is entered" do
      fill_in "Name", with: "StarCraft 2: Heart of the Swarm"
      click_on "Save changes"

      page.should have_content "The game was successfully updated"
      within "table" do
        page.should have_content "StarCraft 2: Heart of the Swarm"
      end
    end

    it "shows errors if invalid information is entered" do
      fill_in 'Name', with: ''
      click_on "Save changes"

      page.should have_content "can't be blank"
    end
  end
end