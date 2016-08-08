class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  has_many :comments
  belongs_to :topic

  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 20}, presence: true
end
