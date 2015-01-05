require "rails_helper"

feature "User Creates Account", %q(
As a prospective user
I want to create an account
So that I can post items and review them

Acceptance Criteria
[ ] Go to users/sign_up to fill out form
[ ] User must provide name and password
[ ] Email must be valid
[ ] Passwords must match

) do

  scenario 'user successfully creates account' do
    visit new_user_registration_path
    fill_in "user[email]", with: "example2@email.com"
    fill_in "user[display_name]", with: "Bob"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully")
  end

  scenario 'user does not have valid email' do
    visit new_user_registration_path
    fill_in "user[email]", with: "example"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    click_button "Sign up"
    expect(page).to have_content("Email is invalid")
  end

  scenario 'passwords do not match' do
    visit new_user_registration_path
    fill_in "user[password]", with: "example2@email.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "notpassword"
    click_button "Sign up"
    expect(page).to have_content("Password confirmation doesn't match")
  end
end
