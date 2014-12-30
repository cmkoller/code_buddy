require "rails_helper"

feature "User Submits a Resource", %q(
As an authenticated user
I want to submit a resource
So that I can share my finding with other users

Acceptance Criteria
[ ] Go to resources/new to fill out form
[ ] User must enter title
[ ] User must enter description
[ ] User must enter url

) do

  context "authenticated user" do
    let(:user){ FactoryGirl.create(:user) }

    before(:each) do
      visit new_user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
    end

    scenario "user successfully submits a resource and reads resource from root_path" do

      visit new_resource_path
      fill_in "Title", with: "Descriptive Title"
      fill_in "Description", with: "this resource is very descriptive"
      fill_in "Url", with: "http://www.google.com"

      click_button "Submit Resource"
      expect(page).to have_content("You've successfully submitted a resource!")
      expect(page).to have_content("Descriptive Title")
      expect(page).to have_content("this resource is very descriptive")
      expect(page).to have_content("http://www.google.com")

      click_link "Code Buddy"
      expect(page).to have_content("Descriptive Title")
    end
  end

  context "unauthenticated user" do
    scenario "user tries to submit resource when not signed in" do
      visit new_resource_path
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end
end
