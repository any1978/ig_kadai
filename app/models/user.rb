class User < ApplicationRecord
  # validation
    validates :name,  presence: true, length: { maximum: 30 }
    validates :email, presence: true, length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    validates :email, uniqueness: true
    before_validation { email.downcase! }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    has_one_attached :image_name
    mount_uploader :image_name, ImageUploader
    
    #association
    has_many :blogs
    has_many :favorites, dependent: :destroy
  end