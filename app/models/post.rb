class Post < ApplicationRecord
  is_impressionable counter_cache: true
  validates :title, presence: true, length: {maximum: 30}
  validates :content, presence: true, length: {maximum: 252}

  belongs_to :user
  belongs_to :post_tag
  has_many :comments
  has_many :bravos
  has_many :bravo_users, through: :bravos, source: 'user', dependent: :destroy
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: 'user', dependent: :destroy

  mount_uploader :image, ImageUploader2
end
