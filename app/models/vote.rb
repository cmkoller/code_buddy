class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :vote_value,
            inclusion: { in: [1, -1] },
            presence: true,
            uniqueness: {scope: :review, message: ": You can't upvote twice"}
  validates :user, presence: true
  validates :review, presence: true
end
