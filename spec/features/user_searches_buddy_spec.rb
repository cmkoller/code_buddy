require "rails_helper"

feature "User Searches for a Buddy", %q(
  As a user
  I want to search for a buddy
  So that I can read the contents of that buddy

  Acceptance Criteria
  [ ] Go to buddies/ to fill out form
  [ ] User must enter search param

) do

    scenario "user successfully submits a search request" do

      rails = FactoryGirl.create(:buddy, title: "Rails video")
      ruby = FactoryGirl.create(:buddy, title: "ruby docs")
      html = FactoryGirl.create(:buddy, title: "html info")

      visit root_path
      fill_in "query", with: "rails"

      click_button "Search"
      expect(page).to have_content(rails.title)
      expect(page).to_not have_content(ruby.title)
      expect(page).to_not have_content(html.title)
    end
end
