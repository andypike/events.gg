module HelperMethods
  def login_as(user)
    unless user.nil?
      # visit logout_path
      visit login_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      within "form" do
        click_on "Login"
      end
    end
  end

  def permission_denied_message
    "You do not have permission to access that page"
  end

  def refresh_page
    visit current_path
  end
end

module Selectors
  def main_menu
    "nav.top-bar"
  end
end

module RouteHelpers
  include Rails.application.routes.url_helpers
end

RSpec.configuration.include HelperMethods, type: :feature
RSpec.configuration.include Selectors, type: :feature
RSpec.configuration.extend RouteHelpers, type: :feature
