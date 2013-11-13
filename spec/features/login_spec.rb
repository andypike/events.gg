require "spec_helper"

describe "A member can login" do
  before do
    visit root_url

    within main_menu do
      click_on "Login"
    end
  end

  it "shows the login page" do
    page.should have_content "Login to your account"
  end

  it "shows the login form" do
    page.should have_field("Email")
    page.should have_field("Password")
    page.should have_button("Login")
  end

  it "logs the member in if valid information is entered" do
    create :user, email: "a@b.com", password: "secret", password_confirmation: "secret"

    fill_in "Email", with: "a@b.com"
    fill_in "Password", with: "secret"

    click_button "Login"

    page.should have_content "You have successfully logged into your account"
  end

  it "shows error if email doesn't match a user" do
    click_button "Login"

    page.should have_content "Either your email address or password wasn't valid"
  end

  it "shows error if password doesn't match" do
    create :user, email: "a@b.com", password: "secret", password_confirmation: "secret"

    fill_in "Email", with: "a@b.com"
    fill_in "Password", with: "just_a_guess"
    click_button "Login"

    page.should have_content "Either your email address or password wasn't valid"
  end

  it "hides the login and signup menu" do
    user = create :user
    login_as user

    within main_menu do
      page.should_not have_link "Login"
      page.should_not have_link "Sign Up"
    end
  end

  it "hides the signup panel on the homepage" do
    user = create :user
    login_as user

    page.should_not have_css ".signup-area"
  end

  it "shows the logged in user's name" do
    user = create :user, name: "Andy Pike"
    login_as user

    within main_menu do
      page.should have_content "Andy Pike"
    end
  end
end
