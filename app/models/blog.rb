class Blog < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
  validates :image, presence: true
  validates :content, length: {in: 1..250 }
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  mount_uploader :image, ImageUploader
end
