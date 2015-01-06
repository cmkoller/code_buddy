class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :vote_value, inclusion: { in: %w(1, -1) }, presence: true
  validates :buddy_id, presence: true
  validates :review_id, presence: true
end
