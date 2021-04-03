class User < ApplicationRecord
  before_save {self.email.downcase!}
  validates :name, presence: true, length: {maximum: 15}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, uniqueness: {case_sensitive: false}, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}
  VALID_PASSWORD_REGEX = /\A(?=\d{0,99}+[a-z])(?=[a-z]{0,99}+\d)[a-z\d]{8,100}+\z/i
  validates :password, presence: true, length: {minimum: 8, maximum: 32}, allow_nil: true, format: { with: VALID_PASSWORD_REGEX}

  has_secure_password
  acts_as_paranoid

  has_many :posts

  mount_uploader :image, ImageUploader
end
