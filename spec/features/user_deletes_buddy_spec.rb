require "rails_helper"

feature "User Deletes a Buddy",
%q(
As the authenticated user that created the buddy
I want to delete the buddy
So that I can remove my buddy from the site

Acceptance Criteria
[ ] Go to buddies/params[:id] to click delete

) do

  let(:buddy) { FactoryGirl.create(:buddy) }
  context "authenticated user" do

    scenario "user successfully deletes buddy" do

      visit new_user_session_path
      fill_in "Email", with: buddy.user.email
      fill_in "Password", with: buddy.user.password
      click_button "Log in"
      visit buddy_path(buddy)

      click_link "Delete"
      expect(page).to have_content("You've successfully deleted a buddy!")

    end
  end
end
