require 'spec_helper'

describe "Show the admin dashboard" do
  
  context "Admin users should have access" do
    before do
      admin = create :admin
      login_as admin

      within main_menu do
        click_on "Admin"
      end
    end

    it "shows the dashboard page" do
      page.should have_content "Admin Dashboard"
    end

    it "uses the /admin path" do
      current_path.should == '/admin'
    end  

    it "shows the admin menu" do
      within main_menu do
        page.should have_link "Admin"
      end
    end  
  end

  shared_examples "disallowed access to non-admins" do
    it "does not show the admin menu" do
      within main_menu do
        page.should_not have_link "Admin"
      end
    end

    it "does not show the dashboard page" do
      visit admin_path

      page.should_not have_content "Admin Dashboard"
      page.should have_content "You do not have permission to access that page"
    end
  end

  context "Normal users who are logged-in should not have access" do
    before do
      user = create :user
      login_as user
    end

    it_behaves_like "disallowed access to non-admins"
  end

  context "Non logged in users should not have access" do
    before do
      visit root_path
    end

    it_behaves_like "disallowed access to non-admins"
  end
end