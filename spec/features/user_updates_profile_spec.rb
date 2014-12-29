require "rails_helper"

feature "User Updates Account", %q(
As an authenticated user
I want to update my information
So that I can keep my profile up to date

Acceptance Criteria
[ ] Go to users/edit to fill out form
[ ] User must enter current password to confirm any changes
[ ] User can only change email
[ ] User can only change password

) do

  let(:user){ FactoryGirl.create(:user) }

  before(:each) do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    visit edit_user_registration_path
  end

  scenario 'user successfully updates email' do
    fill_in "Email", with: "new@email.com"
    fill_in "Current password", with: "password"
    click_button "Update"
    expect(page).to have_content("Your account has been updated successfully")
  end
end
