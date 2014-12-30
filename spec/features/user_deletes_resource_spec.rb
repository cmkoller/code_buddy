require "rails_helper"

feature "User Deletes a Resource", %q(
As the authenticated user that created the resource
I want to delete the resource
So that I can remove my resource from the site

Acceptance Criteria
[ ] Go to resources/params[:id] to click delete

) do

  context "authenticated user" do
    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      visit new_user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
    end

    scenario "user successfully deletes resource" do

      visit new_resource_path
      fill_in "Title", with: "Descriptive Title"
      fill_in "Description", with: "this resource is very descriptive"
      fill_in "Url", with: "http://www.google.com"

      click_button "Submit Resource"
      expect(page).to have_content("You've successfully submitted a resource!")
      expect(page).to have_content("Descriptive Title")
      expect(page).to have_content("this resource is very descriptive")
      expect(page).to have_content("http://www.google.com")

      click_link "Delete"
      expect(page).to have_content("You've successfully deleted a resource!")

    end
  end

  context "unauthenticated user" do
    scenario 'user tries to submit resource when not signed in' do
      visit new_resource_path
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end
end
