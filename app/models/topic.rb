class Topic < ApplicationRecord
  extend FriendlyId
  friendly_id :title, :use => :slugged
  paginates_per 2
  belongs_to :user
  has_many :posts

  validates :title, length: { minimum: 3 }, presence: true
  validates :description, length: { minimum: 10 }, presence: true
end
