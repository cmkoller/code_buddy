require "rails_helper"

feature "User Signs Out", %q(
As an authenticated user
I want to sign out
So that no one else can post items or reviews on my behalf

Acceptance Criteria
[ ] User must log in


) do

  let(:user){ FactoryGirl.create(:user) }

  before(:each) do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  scenario 'user successfully signs out' do
    click_on "Logout"
    expect(page).to have_content("Signed out successfully")
  end
end
