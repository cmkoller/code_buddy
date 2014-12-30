require "rails_helper"

feature "User Edits a Resource", %q(
As the authenticated user that created the resource
I want to edit the resource
So that I can share my update with other users

Acceptance Criteria
[ ] Go to resources/edit to fill out form
[ ] User can update title
[ ] User can update description
[ ] User can update url

) do

  let(:resource) { FactoryGirl.create(:resource) }
  context "authenticated user" do
    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      visit new_user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
    end

    scenario "author of resource successfully edits resource" do
      resource.user_id = user.id
      resource.save
      visit resource_path(resource)
      expect(page).to have_content(resource.title)
      expect(page).to have_content(resource.description)
      expect(page).to have_content(resource.url)

      click_link "Edit"
      fill_in "Title", with: "New Better Title"
      fill_in "Description", with: "New Better Description"
      fill_in "Url", with: "www.NewBetterUrl.com"

      click_button "Submit Resource"
      expect(page).to have_content("You've successfully updated a resource!")

    end

    scenario "not the author of resource tries to edit resource" do
      resource.save
      visit resource_path(resource)
      expect(page).to have_content(resource.title)
      expect(page).to have_content(resource.description)
      expect(page).to have_content(resource.url)

      visit edit_resource_path(resource)
      fill_in "Title", with: "New Better Title"
      fill_in "Description", with: "New Better Description"
      fill_in "Url", with: "www.NewBetterUrl.com"

      click_button "Submit Resource"
      expect(page).to have_content("You are not the owner of that resource")

    end
  end

  context "unauthenticated user" do
    scenario 'user tries to edit resource when not signed in' do
      visit resource_path(resource)

      visit edit_resource_path(resource)
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end
end
