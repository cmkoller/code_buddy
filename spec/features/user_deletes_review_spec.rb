require "rails_helper"

feature "User deletes a review on a buddy", %q(
As an authenticated user
I want to delete a review on a buddy
So that I can delete my thoughts on that buddy with other users

Acceptance Criteria
[ ] Go to /buddies/:buddy_id
[ ] User must delete review
) do

  let(:buddy) { FactoryGirl.create(:buddy) }

  context "authenticated user" do
    let(:user){ FactoryGirl.create(:user) }

    before(:each) do
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "Log in"
    end

    scenario "user successfully deletes a review on a buddy" do

      visit buddy_path(buddy)

      fill_in "review_comment", with: "This is our comment"
      select('horrible - 1', :from => 'review_rating')
      click_button "Submit Review"

      click_link "Delete Review"

      expect(page).to have_content("You've successfully deleted a review!")
    end
  end
end
