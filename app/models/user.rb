class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest
  validates :name, presence: true, length: {maximum: 15}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, uniqueness: {case_sensitive: false}, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}
  VALID_PASSWORD_REGEX = /\A(?=\d{0,99}+[a-z])(?=[a-z]{0,99}+\d)[a-z\d]{8,100}+\z/i
  validates :password, presence: true, length: {minimum: 8, maximum: 32}, allow_nil: true, format: { with: VALID_PASSWORD_REGEX}

  has_secure_password
  acts_as_paranoid

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bravos, dependent: :destroy
  has_many :bravo_posts, through: :bravos, source: 'post'
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: 'post'
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  mount_uploader :image, ImageUploader

  def follow(other_user)
   if self != other_user
     self.relationships.find_or_create_by(follow_id: other_user.id)
   end
  end

  def unfollow(other_user)
   relationship = self.relationships.find_by(follow_id: other_user.id)
   relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    #self.update_attribute(:activated,    true)
    #self.update_attribute(:activated_at, Time.zone.now)
    self.update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private

  private

    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
