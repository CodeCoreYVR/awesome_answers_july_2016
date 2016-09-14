class User < ApplicationRecord
  # more info about has_secure_password can be found here:
  # http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
  # has_secure_password automatically adds attribute accessor for
  # password and password_confirmation.
  # it requires the BCrypt gem and it automatically hashes the password
  # and stores it in the password_digest field.
  # It adds a presence validation to the password.
  # If password_confirmation is provded then it makes sure that it's the same
  # as the password
  has_secure_password

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence:   true,
                    uniqueness: {case_sensitive: false},
                    format:     VALID_EMAIL_REGEX,
                    unless:     :from_oauth?


  # attr_accessor :password, :password_confirmation

  serialize :twitter_data, Hash

  after_initialize :set_defaults
  before_create :generate_api_key

  has_many :questions, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_questions, through: :likes, source: :question

  has_many :votes, dependent: :destroy
  has_many :voted_questions, through: :votes, source: :question

  def from_oauth?
    uid.present? && provider.present?
  end

  def full_name
    "#{first_name} #{last_name}".squeeze(" ").strip.titleize
  end

  def self.find_or_create_from_twitter(twitter_data)
    find_by_twitter(twitter_data) || create_from_twitter(twitter_data)
  end

  def self.find_by_twitter(twitter_data)
    find_by(uid: twitter_data["uid"], provider: twitter_data["provider"])
  end

  def self.create_from_twitter(twitter_data)
    full_name = twitter_data["info"]["name"].split
    create!(first_name:       full_name[0],
           last_name:        full_name[1],
           uid:              twitter_data["uid"],
           provider:         twitter_data["provider"],
           twitter_token:    twitter_data["credentials"]["token"],
           twitter_secret:   twitter_data["credentials"]["secret"],
           password:         SecureRandom.hex(32),
           twitter_raw_data: twitter_data)
  end

  def from_twitter?
    uid.present? && provider == "twitter"
  end

  private

  def set_defaults
    self.admin ||= false
  end

  def generate_api_key
    loop do
      self.api_key = SecureRandom.hex(32)
      break unless User.find_by_api_key(self.api_key)
    end
  end
end
