require "rails_helper"

feature "User Creates Account", %q(
As an administrator of the Code Buddy Website
I want to be able to delete users, code resources, and reviews
So that I can get rid of inappropriate content and users.

Acceptance Criteria


) do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  context "User is admin" do

    before(:each) do
      visit new_user_session_path
      fill_in "user[email]", with: admin.email
      fill_in "user[password]", with: admin.password
      click_button "Log in"
    end

    scenario 'admin views all users' do
      user.save
      visit admin_users_path
      expect(page).to have_content(user.display_name)
    end

    scenario 'admin deletes a user' do
      user.save
      visit admin_users_path
      click_link user.display_name
      click_button "Delete"
      expect(page).to have_content("User successfully deleted")
      expect(page).to have_no_content(user.display_name)
    end
  end

  context "User is not admin" do

    before(:each) do
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "Log in"
    end

    scenario 'normal user cannot view list of users' do
      user.save
      visit admin_users_path
      expect(page).to have_content("You are not authorized to do this")
      expect(page).to have_no_content("Users")

    end

  end
end
