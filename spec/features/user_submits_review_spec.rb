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


  context "authenticated user" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @buddy = FactoryGirl.create(:buddy, user: @user)
      visit new_user_session_path
      fill_in "user[email]", with: @user.email
      fill_in "user[password]", with: @user.password
      click_button "Log in"
    end

    scenario "user successfully submits a review on a buddy" do
      ActionMailer::Base.deliveries = []

      visit buddy_path(@buddy)
      review_comment = "This is our comment"
      fill_in "review_comment", with: review_comment
      select('horrible - 1', :from => 'review_rating')

      click_button "Submit Review"
      expect(page).to have_content("You've successfully submitted a review!")
      expect(page).to have_content("Whatever title")
      expect(page).to have_content("Whatever description lalalala")
      expect(page).to have_content("http://www.whatever.com")
      expect(page).to have_content("This is our comment")

      expect(ActionMailer::Base.deliveries.count).to eql(1)
      last_email = ActionMailer::Base.deliveries.last

      expect(last_email).to have_subject("New Review Posted")
      expect(last_email).to deliver_to(@user.email)
      expect(last_email).to have_body_text(@buddy.title)
    end

    scenario "user unsuccessfully submits a review on a buddy" do
      user = FactoryGirl.create(:user)
      buddy = FactoryGirl.create(:buddy, user: user)
      visit buddy_path(buddy)

      fill_in "review_comment", with: ""
      select('horrible - 1', :from => 'review_rating')

      click_button "Submit Review"
      expect(page).to have_content("Comment can't be blank")
    end
  end
end
