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
  let(:review) { FactoryGirl.create(:review) }

  context "authenticated user" do

    before(:each) do
      visit new_user_session_path
      fill_in "user[email]", with: buddy.user.email
      fill_in "user[password]", with: buddy.user.password

      click_button "Log in"
      visit buddy_path(review.buddy)
    end

    scenario "user successfully upvotes on review" do

      click_button "Yes"
      expect(review.tally).to eq(1)
    end

    scenario "user successfully downvotes on review" do

      click_button "No"
      expect(review.tally).to eq(-1)
    end

    scenario "user can only upvote once per review" do
      click_button "Yes"
      click_button "Yes"
      expect(review.tally).to eq(1)
    end

    scenario "user can only downvote once per review" do
      click_button "No"
      click_button "No"
      expect(review.tally).to eq(-1)
    end

    scenario "user can change their vote" do
      click_button "Yes"
      click_button "No"
      expect(review.tally).to eq(-1)
    end
  end

  context "unaunthenticated user" do

    scenario "user successfully upvotes on review" do
      visit buddy_path(review.buddy)
      expect(page).to have_no_button("Yes")
    end
  end
end
