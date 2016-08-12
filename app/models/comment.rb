class Comment < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :post
  belongs_to :user
  paginates_per 2

  validates :body, length: {minimum: 10}, presence: true
end
