require "rails_helper"

feature "User Reads a Resource", %q(
As an authenticated user
I want to read a resource
So that I can review my resources

Acceptance Criteria
[ ] Go to resources/
[ ] User must be able to view and click title

) do

  context "authenticated user" do
    let(:user){ FactoryGirl.create(:user) }

    before(:each) do
      visit new_user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
    end

    scenario 'user successfully clicks and reads resource from root_path' do

      visit new_resource_path
      fill_in 'Title', with: "Descriptive Title"
      fill_in 'Description', with: "this resource is very descriptive"
      fill_in 'Url', with: "http://www.google.com"

      click_button 'Submit Resource'
      expect(page).to have_content("You've successfully submitted a resource!")
      expect(page).to have_content("Descriptive Title")
      expect(page).to have_content("this resource is very descriptive")
      expect(page).to have_content("http://www.google.com")

      visit root_path
      click_link "Descriptive Title"
      expect(page).to have_content("Descriptive Title")
      expect(page).to have_content("this resource is very descriptive")
      expect(page).to have_content("http://www.google.com")
    end
  end

  context "unauthenticated user" do
    scenario 'user tries to submit resource when not signed in' do
      visit new_resource_path
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end
end
