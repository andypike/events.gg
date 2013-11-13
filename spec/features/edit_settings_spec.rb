require "spec_helper"

describe "A member can edit their settings" do
  let(:current_user) { create :user, name: "Andy Pike" }

  before do
    login_as current_user

    within main_menu do
      click_on "Settings"
    end
  end

  it "shows the settings page" do
    page.should have_content "Your Settings"
  end

  it "shows the settings form" do
    page.should have_field("Name", with: "Andy Pike")
    page.should have_field("Email")
    page.should have_field("Password")
    page.should have_field("Password confirmation")
    page.should have_field("Time zone")
    page.should have_button("Save changes")
  end

  it "updates the settings if they are valid" do
    fill_in "Name", with: "Joe Bloggs"
    click_on "Save changes"

    page.should have_content "Your settings were successfully updated"
    within main_menu do
      page.should have_content "Joe Bloggs"
    end
  end

  it "shows errors if invalid information is entered" do
    fill_in "Name", with: ""
    click_on "Save changes"

    page.should have_content "can't be blank"
  end

  it "keeps user name in menu if the user tries to save a blank name" do
    fill_in "Name", with: ""
    click_on "Save changes"

    within main_menu do
      page.should have_content "Andy Pike"
    end
  end

  it "shows an error message if a non-logged in user tries to access the settings page" do
    click_on "Logout"

    visit settings_path

    page.should have_content permission_denied_message
  end

  it "allows a user to follow games they are interested" do
    create(:game, name: "StarCraft 2")
    visit settings_path

    check "StarCraft 2"
    click_on "Save changes"

    page.should have_content "Your settings were successfully updated"

    visit settings_path

    page.has_checked_field?("StarCraft 2").should be_true
  end
end
