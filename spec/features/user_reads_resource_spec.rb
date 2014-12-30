require "rails_helper"

feature "User Reads a Resource", %q(
As an authenticated user
I want to read a resource
So that I can review my resources

Acceptance Criteria
[ ] Go to resources/
[ ] User must be able to view and click title

) do
    let(:resource) { FactoryGirl.create(:resource) }
  context "authenticated user" do
    let(:user){ FactoryGirl.create(:user) }

    before(:each) do
      visit new_user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
    end

    scenario 'user successfully clicks and reads resource from root_path' do
      resource.save
      visit root_path
      click_link resource.title
      expect(page).to have_content(resource.title)
      expect(page).to have_content(resource.description)
      expect(page).to have_content(resource.url)
    end
  end
end
