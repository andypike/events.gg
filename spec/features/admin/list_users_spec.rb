require 'spec_helper'

describe "Show a list of registered users" do
  context "admin users have access" do
    before do
      admin = create :admin
      login_as admin

      within main_menu do
        click_on "Admin"
      end
    end

    it "shows the users list page" do
      visit admin_path
      click_on "1 User"
      
      page.should have_css("h1", text: "1 User")
    end 

    it "lists the current users" do
      pending
    end
  end
end