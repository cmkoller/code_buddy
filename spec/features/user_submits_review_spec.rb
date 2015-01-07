require "rails_helper"

feature "User Submits a review on a buddy", %q(
As an authenticated user
I want to submit a review on a buddy
So that I can share my thoughts on that buddy with other users

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

    scenario "user successfully submits a review on a buddy" do
      # ActionMailer::Base.notifications = []

      visit buddy_path(buddy)

      fill_in "review_comment", with: "This is our comment"
      select('horrible - 1', :from => 'review_rating')

      click_button "Submit Review"
      expect(page).to have_content("You've successfully submitted a review!")
      expect(page).to have_content("Whatever title")
      expect(page).to have_content("Whatever description lalalala")
      expect(page).to have_content("http://www.whatever.com")
      expect(page).to have_content("This is our comment")
    end

    scenario "user unsuccessfully submits a review on a buddy" do

      visit buddy_path(buddy)

      fill_in "review_comment", with: ""
      select('horrible - 1', :from => 'review_rating')

      click_button "Submit Review"
      expect(page).to have_content("Comment can't be blank")

      expect(ActionMailer::Base.notifications).to eq(1)
      last_email = ActionMailer.base.notifications.last
    end
  end
end
