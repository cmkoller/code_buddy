require "rails_helper"

feature "User Deletes a Resource",
%q(
As the authenticated user that created the resource
I want to delete the resource
So that I can remove my resource from the site

Acceptance Criteria
[ ] Go to resources/params[:id] to click delete

) do

  let(:resource) { FactoryGirl.create(:resource) }
  context "authenticated user" do

    scenario "user successfully deletes resource" do

      visit new_user_session_path
      fill_in "Email", with: resource.user.email
      fill_in "Password", with: resource.user.password
      click_button "Log in"
      visit resource_path(resource)

      click_link "Delete"
      expect(page).to have_content("You've successfully deleted a resource!")

    end
  end
end
