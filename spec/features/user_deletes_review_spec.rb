require "rails_helper"

feature "User deletes a review on a buddy", %q(
As an authenticated user
I want to delete a review on a buddy
So that I can delete my thoughts on that buddy with other users

Acceptance Criteria
[ ] Go to /buddies/:buddy_id
[ ] User must delete review
) do

  context "authenticated user" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @buddy = FactoryGirl.create(:buddy)

      visit new_user_session_path
      fill_in "user[email]", with: @user.email
      fill_in "user[password]", with: @user.password
      click_button "Log in"
    end

    scenario "user successfully deletes a review on a buddy" do
      FactoryGirl.create(:review, buddy: @buddy, user: @user)
      visit buddy_path(@buddy)
      click_link "Delete Review"
      expect(page).to have_content("You've successfully deleted a review!")
    end
  end
end
