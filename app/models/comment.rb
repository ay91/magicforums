class Comment < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :post
  belongs_to :user
  paginates_per 4

  validates :body, length: {minimum: 2}, presence: true
end
