require "rails_helper"

feature "Admin Deletes Content", %q(
As an administrator of the Code Buddy Website
I want to be able to delete users, code resources, and reviews
So that I can get rid of inappropriate content and users.

Acceptance Criteria


) do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, admin: true) }
  let(:buddy) { FactoryGirl.create(:buddy) }

  context "User is admin" do

    before(:each) do
      admin.display_name = "Mr. Admin"
      admin.save
      visit new_user_session_path
      fill_in "user[email]", with: admin.email
      fill_in "user[password]", with: admin.password
      click_button "Log in"
    end

    scenario "admin views all users" do
      user = FactoryGirl.create(:user)
      visit admin_users_path
      expect(page).to have_content(user.display_name)
    end

    scenario "admin deletes a user" do
      user = FactoryGirl.create(:user)
      visit admin_users_path
      click_link user.display_name
      click_button "Delete"
      expect(page).to have_content("User successfully deleted")
      expect(page).to_not have_content(user.display_name)
    end

    scenario "admin deletes a buddy" do
      visit buddy_path(buddy)
      click_link "delete-buddy"
      expect(page).to have_content("You've successfully deleted a buddy!")
      expect(page).to_not have_content(buddy.title)
    end

    scenario "admin deletes a review" do
      FactoryGirl.create(:review, buddy: buddy)
      visit buddy_path(buddy)
      click_link "Delete Review"
      expect(page).to have_content("You've successfully deleted a review!")
    end
  end

  context "User is not admin" do

    before(:each) do
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "Log in"
    end

    scenario "normal user cannot view list of users" do
      visit admin_users_path
      expect(page).to have_content("You are not authorized to do this")
      expect(page).to have_no_content("Users")
    end

    scenario "normal user cannot delete a user" do
      user2 = FactoryGirl.create(:user)
      user2.display_name = "Joe"
      user2.save
      visit user_path(user2)
      expect(page).to have_no_button("Delete")
      page.driver.submit :delete, admin_user_path(user2), {}
      expect(page).to have_content("You are not authorized to do this")
      visit user_path(user2)
      expect(page).to have_content(user2.display_name)
    end

    scenario "normal user cannot delete a buddy" do
      visit buddy_path(buddy)
      expect(page).to have_no_content("Delete")
      page.driver.submit :delete, buddy_path(buddy), {}
      expect(page).to have_content("You are not authorized to do this")
    end

    scenario "normal user cannot delete a review" do
      FactoryGirl.create(:review, buddy: buddy)
      visit buddy_path(buddy)
      expect(page).to have_no_content("Delete")
      page.driver.submit :delete, buddy_path(buddy), {}
      expect(page).to have_content("You are not authorized to do this")
    end

  end
end
