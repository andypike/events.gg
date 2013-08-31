require 'spec_helper'

describe "A member can create a new organisation" do
  let(:current_user) { create :user }

  before do
    login_as current_user

    within main_menu do
      click_on "Organisations"
    end

    click_on "Create an Organisation"
  end

  it "shows the new organisation form" do
    page.should have_field('Name')
    page.should have_button('Create organisation')
  end

  it "creates an organisation if valid information is entered" do
    fill_in "Name", with: "MLG"
    
    click_on "Create organisation"

    page.should have_content "You have successfully created an organisation."
  end
end