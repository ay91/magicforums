class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_secure_password
  has_many :topics
  has_many :posts
  has_many :comments
  has_many :votes

  enum role: [:user, :moderator, :admin]
end
