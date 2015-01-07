class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :vote_value,
    inclusion: { in: [1, -1] },
    presence: true
  validates :user, presence: true,
    uniqueness: { scope: :review }
  validates :review, presence: true
end
