class Comment < ApplicationRecord
  # mount_uploader :image, ImageUploader
  belongs_to :post
  belongs_to :user
  paginates_per 4
  has_many :votes
  validates :body, length: {minimum: 2}, presence: true

  def total_votes
    votes.pluck(:value).sum
  end

end
