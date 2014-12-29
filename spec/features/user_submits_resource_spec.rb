require "rails_helper"

feature "User Submits a Resource", %q(
As an authenticated user
I want to submit a resource
So that I can share my finding with other users

Acceptance Criteria
[ ] Go to resources/new to fill out form
[ ] User must enter title
[ ] User must enter description
[ ] User must enter url

) do

  # user = FactoryGirl.create(:user)
  #
  # before(:each) do
  #   visit new_user_session_path
  #   fill_in "Email", with: user.email
  #   fill_in "Password", with: user.password
  #   click_button "Log in"
  #   visit edit_user_registration_path
  # end
  #
  scenario 'user successfully submits a resource' do
    visit new_resource_path
    fill_in 'Title', with: "Descriptive Title"
    fill_in 'Description', with: "this resource is very descriptive"
    fill_in 'Url', with: "http://www.google.com"

    click_button 'Submit Resource'
    expect(page).to have_content("You've successfully submitted a resource!")
    expect(page).to have_content("Descriptive Title")
    expect(page).to have_content("this resource is very descriptive")
    expect(page).to have_content("http://www.google.com")

  end
end