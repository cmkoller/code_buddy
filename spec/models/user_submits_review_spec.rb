require "spec_helper"

# RSpec.describe ReviewAlert, :type => :model do
describe ReviewAlert do

  # it "posts a valid review" do
  #   review = FactoryGirl.build(:review)
  #   review.should be_valid
  # end

  it "sends an alert when review is posted" do
    ActionMailer::Base.deliveries = []
    buddy = FactoryGirl.create(:buddy)
    review = FactoryGirl.create(:review, buddy: buddy)
    buddy.reviewed(review)
    expect(ActionMailer::Base.deliveries.size).to eql(1)
  end

  # it "posts an invalid review" do
  #   review = FactoryGirl.build(:review, rating: nil)
  #   review.should_not be_valid
  # end
end
