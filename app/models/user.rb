class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, :use => :slugged
  mount_uploader :image, ImageUploader
  has_secure_password
  has_many :topics
  has_many :posts
  has_many :comments
  has_many :votes

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}

  enum role: [:user, :moderator, :admin]
end
