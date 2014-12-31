require "rails_helper"

feature "User Signs In", %q(
As an unauthenticated user
I want to sign in
So that I can post items and review them

Acceptance Criteria
[ ] User must visit "/users/sign_in"
[ ] User must enter valid email and password
[ ] User will recieve an error if incorrect email/passord combo


) do

  let(:user){ FactoryGirl.create(:user) }

  scenario 'user successfully signs in' do
    visit new_user_session_path
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    click_button "Log in"
    expect(page).to have_content("Signed in successfully")
  end

  scenario 'user enters invalid email' do
    visit new_user_session_path
    fill_in "user[email]", with: "notmyemail@email.com"
    fill_in "user[password]", with: user.password
    click_button "Log in"
    expect(page).to have_content("Invalid email or password")
  end

  scenario 'user enters invalid password' do
    visit new_user_session_path
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: "notmypassword"
    click_button "Log in"
    expect(page).to have_content("Invalid email or password")
  end
end
