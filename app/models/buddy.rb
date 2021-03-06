class Buddy < ActiveRecord::Base
  belongs_to :user
  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates_format_of :url, :with => URI::regexp(%w(http https)), presence: true

  def reviewed(review)
    ReviewAlert.notification(review).deliver
    return true
  end

  def self.search(query)
    where("title ILIKE ?", "%#{query}%")
  end
end
