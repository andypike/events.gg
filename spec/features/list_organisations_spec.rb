require 'spec_helper'

describe "A member can see a list of organisations that they are part of" do
  let(:no_organisation_message) { "You are not part of an organisation at the moment" }
  let(:current_user) { create :user }

  before do
    login_as current_user

    within main_menu do
      click_on "Organisations"
    end
  end

  it "shows the organisations page" do
    page.should have_content "Your Organisations"
  end

  it "shows a message if the current user is not part of any organisation" do
    page.should have_content no_organisation_message
  end

  it "shows a list of organisations that only the current user is linked with" do
    other_user = create(:user)
    dreamhack = create(:organisation, name: "Dreamhack")
    mlg = create(:organisation, name: "MLG")
    invitation = create(:invitation, user: current_user, organisation: mlg)
    invitation = create(:invitation, user: other_user, organisation: dreamhack)

    refresh_page

    page.should have_content "MLG"
    page.should_not have_content "Dreamhack"
    page.should_not have_content no_organisation_message
  end
end