class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :comments
  belongs_to :topic
  paginates_per 3

  validates :title, length: {minimum: 3}, presence: true
  validates :body, length: {minimum: 10}, presence: true
end
