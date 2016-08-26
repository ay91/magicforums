class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, :use => :slugged
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :comments
  belongs_to :topic
  paginates_per 3

  validates :title, length: {minimum: 3}, presence: true
  validates :body, length: {minimum: 10}, presence: true

  before_save :update_slug

  private

  def update_slug
    if title
      self.slug = title.gsub(" ", "-")
    end
  end
end
