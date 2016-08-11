class Topic < ApplicationRecord
  belongs_to :user
  has_many :posts

  validates :title, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 20 }, presence: true
end
