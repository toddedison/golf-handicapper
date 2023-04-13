class User < ApplicationRecord
  BETTER_GOLFER_NARROW_BELL_CURVE_VALUE = 0.96
  has_many :microposts, dependent: :destroy
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest
  mount_uploader :picture, PictureUploader

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
  validate  :picture_size

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def handicap
    handicap_holder = Array.new

    self.microposts.each do |micropost|
       handicap_holder << get_handicap(micropost).round(1)
    end

    get_average_handicap(handicap_holder)
  end

  private

    def get_handicap(micropost)
      (micropost.score - micropost.rating) * 113 / micropost.slope
    end

    def calculate_average_handicap(handicaps, divisor)
      handicaps.sort.first(divisor).sum / divisor
    end

    def get_average_handicap(handicaps)
      handicap = 0
      divisor = case handicaps.count
      when 0..6 then 1
      when 0..9 then 2
      when 0..11 then 3
      when 0..13 then 4
      when 0..15 then 5
      when 0..17 then 6
      when 17 then 7
      when 18 then 8
      when 19 then 9
      when 20 then 10
      else  0
      end
      (calculate_average_handicap(handicaps, divisor) *
        BETTER_GOLFER_NARROW_BELL_CURVE_VALUE).round(1)
    end


    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end



end
