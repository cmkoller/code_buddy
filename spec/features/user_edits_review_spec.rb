require "rails_helper"

feature "User Edits a review on a buddy", %q(
As an authenticated user
I want to edit a review on a buddy
So that I can share my updated thoughts on that buddy with other users

Acceptance Criteria
[ ] Go to /buddies/:buddy_id to fill out form
[ ] User must enter comment
[ ] User must enter rating
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

    scenario "user successfully edits a review on a buddy" do

      visit buddy_path(buddy)

      fill_in "review_comment", with: "This is our comment"
      select('horrible - 1', :from => 'review_rating')
      click_button "Submit Review"

      click_link "Edit Review"
      fill_in "review_comment", with: "Even newer updated comment"
      select('horrible - 1', :from => 'review_rating')
      click_button "Submit Review"
      expect(page).to have_content("You've successfully updated your review!")


    end

    scenario "user unsuccessfully edits a review on a buddy" do

      visit buddy_path(buddy)

      fill_in "review_comment", with: "This is our comment"
      select('horrible - 1', :from => 'review_rating')
      click_button "Submit Review"

      click_link "Edit Review"
      fill_in "review_comment", with: ""
      select('horrible - 1', :from => 'review_rating')

      click_button "Submit Review"
      expect(page).to have_content("Comment can't be blank")
    end
  end
end
