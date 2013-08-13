require 'spec_helper'

describe "Show a list of registered users" do
  context "admin users have access" do
    before do
      admin = create :admin, name: "Andy Pike"
      login_as admin

      within main_menu do
        click_on "Admin"
      end

      click_on "1 User"
    end

    it "shows the users list page" do
      page.should have_css("h1", text: "1 User")
    end 

    it "lists the current users" do
      page.should have_css("table tbody td", text: "Andy Pike")
    end
  end
end