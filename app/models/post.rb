class Post < ApplicationRecord
  validates :title, presence: true, length: {maximum: 40}
  validates :content, presence: true, length: {maximum: 280}

  belongs_to :user
  belongs_to :post_tag
  has_many :comments
  has_many :bravos
  has_many :bravo_users, through: :bravos, source: 'user', dependent: :destroy
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: 'user', dependent: :destroy

  mount_uploader :image, ImageUploader
end
