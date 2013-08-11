module HelperMethods
  def login_as(user)
    unless user.nil?
      #visit logout_path
      visit login_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      within "form" do
        click_on 'Login'
      end
    end
  end
end

module Selectors
  def main_menu
    "nav.top-bar"
  end
end

RSpec.configuration.include HelperMethods, type: :feature
RSpec.configuration.include Selectors, type: :feature
