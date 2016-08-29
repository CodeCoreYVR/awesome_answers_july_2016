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
                    format:     VALID_EMAIL_REGEX


  # attr_accessor :password, :password_confirmation

  after_initialize :set_defaults

  has_many :questions, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_questions, through: :likes, source: :question

  has_many :votes, dependent: :destroy
  has_many :voted_questions, through: :votes, source: :question

  def full_name
    "#{first_name} #{last_name}".squeeze(" ").strip.titleize
  end

  private

  def set_defaults
    self.admin ||= false
  end
end
