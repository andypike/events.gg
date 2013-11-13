require "spec_helper"

describe "Edit a registered user" do
  context "admin users have access" do
    before do
      admin = create :admin, name: "Andy Pike", email: "a@b.com"
      login_as admin

      within main_menu do
        click_on "Admin"
      end

      click_on "1 User"
      click_on "Edit"
    end

    it "shows the edit user page" do
      page.should have_content "Editing Andy Pike"
    end

    it "shows a populated form" do
      page.should have_field("Name", with: "Andy Pike")
      page.should have_field("Email", with: "a@b.com")
      page.should have_field("Password")
      page.should have_field("Password confirmation")
      page.should have_select("Time zone")
      page.should have_select("Role", selected: "Admin")
      page.should have_button("Save changes")
    end

    it "updates the user if valid data is entered" do
      fill_in "Name", with: "Joe Bloggs"
      click_on "Save changes"

      page.should have_content "The user's settings were successfully updated"
      within "table" do
        page.should have_content "Joe Bloggs"
      end
    end

    it "shows errors if invalid information is entered" do
      fill_in "Name", with: ""
      click_on "Save changes"

      page.should have_content "can't be blank"
    end
  end
end
