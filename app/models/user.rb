class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token

  before_save   :downcase_email  # Standardizes on all lower-case addresses.
  before_create :create_activation_digest

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password  # Incl. presence and matching validations.
  validates :password, length: { minimum: 6 }, allow_blank: true

  # Remembers a user in the database for use in persistent sessions.
  # Generates a new token and a corresponding digest upon every call.
  def save_remember_digest
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def delete_remember_digest
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticate_with_token(token_type, token)
    digest = send("#{token_type}_digest")
    # Avoid raising error in case of nil remember_digest.
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  #-----------------------------------------------------------------------------
  class << self

    # Returns the hash digest of the given string.
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  #-----------------------------------------------------------------------------
  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
