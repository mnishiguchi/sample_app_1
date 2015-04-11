class User < ActiveRecord::Base
  attr_accessor :remember_token

  # standardize on all lower-case addresses
  before_save { self.email.downcase! }

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password  # incl presence and matching validations
  validates :password, length: { minimum: 6 }

  #-----------------------------------------------------------------------------

  class << self

    # return the hash digest of the given string
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # return a random token
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  #-----------------------------------------------------------------------------

  # remember a user in the database for use in persistent sessions
  # generate a new token and a corresponding digest on every call
  def save_remember_digest
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # forget a user
  def delete_remember_digest
    update_attribute(:remember_digest, nil)
  end

  # return true if the given token matches the digest
  def authenticate_with_token(token_type, token)
    digest = send("#{token_type}_digest")
    # avoid raising error in case of nil remember_digest
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
end
