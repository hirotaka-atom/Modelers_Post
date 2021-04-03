class Post < ApplicationRecord
  validates :title, presence: true, length: {maximum: 40}
  validates :content, presence: true, length: {maximum: 280}
  validates :user_id, presence: true

  belongs_to :user

  mount_uploader :image, ImageUploader
end
