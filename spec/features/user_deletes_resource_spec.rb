require "rails_helper"

feature "User Deletes a Resource", %q(
As the authenticated user that created the resource
I want to delete the resource
So that I can remove my resource from the site

Acceptance Criteria
[ ] Go to resources/params[:id] to click delete

) do

    let(:resource) { FactoryGirl.create(:resource) }
  context "authenticated user" do
    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      visit new_user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
    end

    scenario "user successfully deletes resource" do

      visit resource_path(resource)
      expect(page).to have_content(resource.title)
      expect(page).to have_content(resource.description)
      expect(page).to have_content(resource.url)

      click_link "Delete"
      expect(page).to have_content("You've successfully deleted a resource!")

    end
  end

  context "unauthenticated user" do
    scenario 'user tries to delete resource when not signed in' do
      visit resource_path(resource)

      click_link "Delete"
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end
end
