class Review < ActiveRecord::Base
  belongs_to :buddy
  belongs_to :user
  has_many :votes

  validates :comment, presence: true
  validates :rating, presence: true

  def tally
    votes.sum(:vote_value)
  end
end
