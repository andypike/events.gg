require 'spec_helper'

describe "Show a list of organisations" do
  context "admin users have access" do
    before do
      create :organisation, name: "MLG"
      admin = create :admin
      login_as admin

      within main_menu do
        click_on "Admin"
      end

      click_on "1 Organisation"
    end

    it "shows the organisations list page" do
      page.should have_css("h1", text: "1 Organisation")
    end 

    it "lists the current organisations" do
      page.should have_css("table tbody td", text: "MLG")
    end
  end
end