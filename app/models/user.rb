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
  validates :username, presence: true, uniqueness: true

  enum role: [:user, :moderator, :admin]

  before_save :update_slug

  private

  def update_slug
    if username
      self.slug = username.gsub(" ", "-")
    end
  end
end
