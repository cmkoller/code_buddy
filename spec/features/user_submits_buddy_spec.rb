require "rails_helper"

feature "User Submits a Buddy", %q(
As an authenticated user
I want to submit a buddy
So that I can share my finding with other users

Acceptance Criteria
[ ] Go to buddies/new to fill out form
[ ] User must enter title
[ ] User must enter description
[ ] User must enter url

) do

  context "authenticated user" do
    let(:user){ FactoryGirl.create(:user) }

    before(:each) do
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "Log in"
    end

    scenario "user successfully submits a buddy and reads buddy from root_path" do

      visit root_path
      click_link "Create New Buddy"
      fill_in "Title", with: "Descriptive Title"
      fill_in "Description", with: "this buddy is very descriptive"
      fill_in "Url", with: "http://www.google.com"

      click_button "Submit Buddy"
      expect(page).to have_content("You've successfully submitted a buddy!")
      expect(page).to have_content("Descriptive Title")
      expect(page).to have_content("this buddy is very descriptive")
      expect(page).to have_content("http://www.google.com")

      click_link "Code Buddy"
      expect(page).to have_content("Descriptive Title")
    end
  end

  context "unauthenticated user" do
    scenario "user tries to submit buddy when not signed in" do
      visit new_buddy_path
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end
end
