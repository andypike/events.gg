require "spec_helper"

describe "Edit an organisation" do
  context "admin users have access" do
    before do
      create :organisation, name: "MLG", status: "approved"
      admin = create :admin
      login_as admin

      within main_menu do
        click_on "Admin"
      end

      click_on "1 Organisation"
      click_on "Edit"
    end

    it "shows the edit organisation page" do
      page.should have_content "Editing MLG"
    end

    it "shows a populated form" do
      page.should have_field("Name", with: "MLG")
      page.should have_select("Status", selected: "Approved")
      page.should have_button("Save changes")
    end

    it "updates the organisation if valid data is entered" do
      fill_in "Name", with: "MLG Summer"
      click_on "Save changes"

      page.should have_content "The organisation was successfully updated"
      within "table" do
        page.should have_content "MLG Summer"
      end
    end

    it "shows errors if invalid information is entered" do
      fill_in "Name", with: ""
      click_on "Save changes"

      page.should have_content "can't be blank"
    end
  end
end
