require 'spec_helper'

describe "Show the admin dashboard" do
  
  context "admin users should have access" do
    before do
      admin = create :admin
      login_as admin

      within main_menu do
        click_on "Admin"
      end
    end

    it "shows the admin menu" do
      within main_menu do
        page.should have_link "Admin"
      end
    end  

    it "shows the dashboard page" do
      page.should have_content "Admin Dashboard"
    end

    it "uses the /admin path" do
      current_path.should == '/admin'
    end  

    it "shows the current number of users" do
      page.should have_content "1 User"
    end
  end

  context "hide the admin menu for" do
    it "logged in normal users" do
      login_as(create :user)

      within main_menu do
        page.should_not have_link "Admin"
      end
    end 
  
    it "non-logged in users" do
      visit root_path

      within main_menu do
        page.should_not have_link "Admin"
      end
    end 
  end
end