require 'spec_helper'

describe "Add a new game" do
  context "admin users have access" do
    before do
      admin = create :admin
      login_as admin

      within main_menu do
        click_on "Admin"
      end

      click_on "0 Games"
      click_on "Add a new game"
    end

    it "shows the new game page" do
      page.should have_content "Adding a new game"
    end 

    it "shows the form" do
      page.should have_field('Name')
      page.should have_select('Status')
      page.should have_button('Save changes')
    end

    it "creates the game if valid data is entered" do
      fill_in "Name", with: "League of Legends"
      click_on "Save changes"

      page.should have_content "The game was successfully added"
      within "table" do
        page.should have_content "League of Legends"
      end
    end

    it "shows errors if invalid information is entered" do
      fill_in 'Name', with: ''
      click_on "Save changes"

      page.should have_content "can't be blank"
    end
  end
end