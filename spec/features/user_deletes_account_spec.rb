# As an authenticated user
# I want to delete my account
# So that my information is no longer retained by the app

require "rails_helper"

feature "User Deletes Account", %q(
As an authenticated user
I want to delete my account
So that my information is no longer retained by the app

Acceptance Criteria
[ ] User must be logged in
[ ] User must click cancel my account

) do

  let(:user){ FactoryGirl.create(:user) }

  before(:each) do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    visit edit_user_registration_path
  end

  scenario 'user successfully deletes account' do
    click_button "Cancel my account"
    expect(page).to have_content("Your account has been successfully cancelled")
  end
end
