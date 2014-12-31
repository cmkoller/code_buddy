require "rails_helper"

feature "User Edits a Buddy", %q(
As the authenticated user that created the buddy
I want to edit the buddy
So that I can share my update with other users

Acceptance Criteria
[ ] Go to buddies/edit to fill out form
[ ] User can update title
[ ] User can update description
[ ] User can update url

) do

  let(:buddy) { FactoryGirl.create(:buddy) }
  context "authenticated user" do

    scenario "author of buddy successfully edits buddy" do

      visit new_user_session_path
      fill_in "user[email]", with: buddy.user.email
      fill_in "user[password]", with: buddy.user.password

      click_button "Log in"
      visit buddy_path(buddy)

      click_link "Edit"
      fill_in "Title", with: "New Better Title"
      fill_in "Description", with: "New Better Description"
      fill_in "Url", with: "www.NewBetterUrl.com"

      click_button "Submit Buddy"
      expect(page).to have_content("You've successfully updated a buddy!")

    end

    scenario "not the author of buddy tries to edit buddy" do
      user2 = FactoryGirl.create(:user)
      visit new_user_session_path
      fill_in "user[email]", with: user2.email
      fill_in "user[password]", with: user2.password
      click_button "Log in"

      expect { visit edit_buddy_path(buddy) }.to raise_error(ActiveRecord::RecordNotFound)

    end
  end

  context "unauthenticated user" do
    scenario "user tries to edit buddy when not signed in" do
      visit buddy_path(buddy)

      visit edit_buddy_path(buddy)
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end
end
