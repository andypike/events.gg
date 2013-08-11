require 'spec_helper'

describe "A visitor to the site can sign up" do
  before do
    visit root_url

    within main_menu do
      click_on "Sign Up"
    end
  end

  it "shows the register page" do
    page.should have_content "Sign up for a free account"
  end

  it "shows the sign up form" do
    page.should have_field('Name')
    page.should have_field('Email')
    page.should have_field('Password')
    page.should have_field('Password confirmation')
    page.should have_field('Time zone')
    page.should have_button('Create account')
  end

  it "creates an account if valid information is entered" do
    fill_in "Name", with: "Andy"
    fill_in "Email", with: "andy@andypike.com"
    fill_in "Password", with: "secret"
    fill_in "Password confirmation", with: "secret"
    select "London", :from => "Time zone"

    click_on "Create account"

    page.should have_content "You have successfully created an account."
    within main_menu do
      page.should have_content "Andy"
    end
  end

  it "shows errors if invalid information is entered" do
    click_on "Create account"

    page.should have_content "can't be blank"
  end
end