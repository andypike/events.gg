require 'spec_helper'

describe "A member can logout" do
  before do
    visit root_url
  end

  it "doesn't show the logout link if not logged in" do
    within main_menu do
      page.should_not have_link "Logout"
    end
  end

  it "shows the logout link if logged in" do
    user = create :user
    login_as user

    within main_menu do
      page.should have_link "Logout"
    end
  end

  it "show logout message and clear session" do
    user = create :user
    login_as user    

    within main_menu do
      click_on "Logout"
    end

    page.should have_content "You have successfully logged out"
    within main_menu do
      page.should_not have_content user.name
    end
  end
end