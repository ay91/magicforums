class Topic < ApplicationRecord
  paginates_per 1
  belongs_to :user
  has_many :posts

  validates :title, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 20 }, presence: true
end
