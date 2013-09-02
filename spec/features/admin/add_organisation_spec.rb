require 'spec_helper'

describe "Add a new organisation" do
  context "admin users have access" do
    before do
      admin = create :admin
      login_as admin

      within main_menu do
        click_on "Admin"
      end

      click_on "0 Organisations"
      click_on "Add a new organisation"
    end

    it "shows the new organisation page" do
      page.should have_content "Adding a new organisation"
    end 

    it "shows the form" do
      page.should have_field('Name')
      page.should have_select('Status')
      page.should have_button('Save changes')
    end

    it "creates the organisation if valid data is entered" do
      fill_in "Name", with: "MLG"
      click_on "Save changes"

      page.should have_content "The organisation was successfully added"
      within "table" do
        page.should have_content "MLG"
      end
    end

    it "shows errors if invalid information is entered" do
      fill_in 'Name', with: ''
      click_on "Save changes"

      page.should have_content "can't be blank"
    end
  end
end