require "rails_helper"

feature "User votes on a Review",
%q(
As an authenticated user
I want to vote on a Review
So that I can share how helpful the review is

Acceptance Criteria
[ ] User must be signed in
[ ] User has to go to buddy/buddy[:id]
[ ] User should click up/down

) do

  let(:buddy) { FactoryGirl.create(:buddy) }
  context "authenticated user" do

    scenario "user successfully votes on review" do

      visit new_user_session_path
      fill_in "user[email]", with: buddy.user.email
      fill_in "user[password]", with: buddy.user.password

      click_button "Log in"

      review = FactoryGirl.create(:review)
      visit buddy_path(review.buddy)

      click_button "yes"

      expect(review.tally).to eq(1)


    end
  end
end
