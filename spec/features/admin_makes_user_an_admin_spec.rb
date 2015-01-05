require "rails_helper"

feature "Admin Makes User Into Admin", %q(
As an administrator of the Code Buddy Website
I want to be able to make other users into admins
So that I can have help weeding through the terrible things people post.

Acceptance Criteria


) do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:buddy) { FactoryGirl.create(:buddy) }

  context "User is admin" do

    before(:each) do
      visit new_user_session_path
      fill_in "user[email]", with: admin.email
      fill_in "user[password]", with: admin.password
      click_button "Log in"
    end

    scenario "admin successfully makes another user into an admin" do
      visit user_path(user)
      click_button "Make Admin"
      expect(page).to have_content("#{user.display_name} is now an admin!")
    end

  end

  context "User is not admin" do

    before(:each) do
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "Log in"
    end

    scenario "normal user cannot make another user into an admin" do
      visit user_path(user)
      expect(page).to have_no_content("Make Admin")
      page.driver.submit :patch, admin_user_path(user), admin: true
      expect(page).to have_content("You are not authorized to do this")
    end
  end

end
