class Comment < ApplicationRecord
  validates :content, presence: true, length: {maximum: 280}

  belongs_to :user
  belongs_to :post

  mount_uploader :image, ImageUploader
end
