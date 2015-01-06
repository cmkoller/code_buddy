class Review < ActiveRecord::Base
  belongs_to :buddy
  belongs_to :user
  has_many :votes

  validates :comment, presence: true
  validates :rating, presence: true


  def tally
    sum = 0
    votes.each do |vote|
      sum += vote.vote_value
    end
    sum
  end
end
