class Post < ApplicationRecord
  is_impressionable counter_cache: true
  validates :title, presence: true, length: {maximum: 30}
  validates :content, presence: true, length: {maximum: 252}

  belongs_to :user
  belongs_to :post_tag
  has_many :comments, dependent: :destroy
  has_many :bravos, dependent: :destroy
  has_many :bravo_users, through: :bravos, source: 'user'
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: 'user'

  mount_uploader :image, ImageUploader2
end
