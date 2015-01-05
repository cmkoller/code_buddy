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

    # scenario 'admin deletes a user' do
    #   user.save
    #   visit admin_users_path
    #   click_link user.display_name
    #   click_button "Delete"
    #   expect(page).to have_content("User successfully deleted")
    #   expect(page).to have_no_content(user.display_name)
    # end
    #
    # scenario 'admin deletes a buddy' do
    #   visit buddy_path(buddy)
    #   click_link "Delete"
    #   expect(page).to have_content("You've successfully deleted a buddy!")
    # end
  end

  # context "User is not admin" do
  #
  #   before(:each) do
  #     visit new_user_session_path
  #     fill_in "user[email]", with: user.email
  #     fill_in "user[password]", with: user.password
  #     click_button "Log in"
  #   end
  #
  #   scenario 'normal user cannot view list of users' do
  #     visit admin_users_path
  #     expect(page).to have_content("You are not authorized to do this")
  #     expect(page).to have_no_content("Users")
  #   end
  #
  #   scenario 'normal user cannot delete a user' do
  #     user2 = user
  #     user2.display_name = "Joe"
  #     user2.save
  #     visit user_path(user2)
  #     expect(page).to have_no_button("Delete")
  #     page.driver.submit :delete, admin_user_path(user2), {}
  #     expect(page).to have_content("You are not authorized to do this")
  #     expect(page).to have_content(user2.display_name)
  #   end
  #
  #   scenario 'normal user cannot delete a buddy' do
  #     visit buddy_path(buddy)
  #     expect(page).to have_no_content("Delete")
  #     page.driver.submit :delete, buddy_path(buddy), {}
  #     expect(page).to have_content("You are not authorized to do this")
  #   end
  #
  # end
end
