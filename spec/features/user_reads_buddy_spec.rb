require "rails_helper"

feature "User Reads a Buddy", %q(
As an authenticated user
I want to read a buddy
So that I can review my buddys

Acceptance Criteria
[ ] Go to buddys/
[ ] User must be able to view and click title

) do
  let(:buddy) { FactoryGirl.create(:buddy) }
  context "authenticated user" do
    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      visit new_user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
    end

    scenario "user successfully clicks and reads buddy from root_path" do
      buddy.save
      visit root_path
      click_link buddy.title
      expect(page).to have_content(buddy.title)
      expect(page).to have_content(buddy.description)
      expect(page).to have_content(buddy.url)
    end
  end
end
