class Review < ActiveRecord::Base
  belongs_to :buddy
  belongs_to :user


  validates :comment, presence: true
  validates :rating, presence: true

end
