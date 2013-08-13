require 'spec_helper'

describe "Access control to admin pages" do
  admin_routes = [admin_path, admin_users_path, edit_admin_user_path(1)]

  admin_routes.each do |path|
    context "disallow access to #{path}" do
      it "non-logged in users" do
        visit path
        page.should have_content permission_denied_message
      end

      it "logged in normal users" do
        login_as(create :user)

        visit path
        page.should have_content permission_denied_message
      end
    end
  end
end