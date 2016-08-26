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
  validate :image_size

  before_save :update_slug

  private

  def image_size
    return unless image
    if image.size > 1.megabyte
      errors.add(:image, "size is too big. Please make sure it is 1MB or smaller.")
    end
  end

  def update_slug
    if title
      self.slug = title.gsub(" ", "-")
    end
  end
end
