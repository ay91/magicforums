class Comment < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :post

  validates :body, length: {minimum: 10}, presence: true
end
