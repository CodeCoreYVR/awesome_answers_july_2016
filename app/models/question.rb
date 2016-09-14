class Question < ApplicationRecord
  # this will help us store / retrieve a field `tweet_it` without persisting to
  # the database
  attr_accessor :tweet_it

  # this associates the question with answer in a one-to-many fashion
  # this will give us handy methods to easily created associated answers and
  # fetch associated answers as well. Note that it should be pluralized for
  # one to many association.
  # You should also add a dependent option. The value can be:
  # destroy: will delete associated answers before deleting a question
  # nullify: will make question_id `null` for associated answers before deleting
  has_many :answers, dependent: :destroy

  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  has_many :votes, dependent: :destroy
  has_many :voting_users, through: :votes, source: :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  # validates(:title, {presence: true})
  validates :title, presence: true, uniqueness: {message: "must be unique!"}
  validates :body, presence: true, length: {minimum: 5}

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  # :image refers to the field in the database that stores the file name
  # ImageUploader refers to the Uploader class we generated with carrierwave
  mount_uploader :image, ImageUploader

  # This validatse that the title/body combination is unique which means that
  # title doesn't have to be unique by itself, body doesn't have to be unique
  # by itself but the combination of the two must be unique.
  # validates :body, uniqueness: {scope: :title}

  # VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # validates :email, format: VALID_EMAIL_REGEX

  # this defines a custom validation. It takes a first argument which in this
  # case is a private method
  validate :no_monkey

  after_initialize :set_defaults

  before_validation :capitalize_title

  def titleized_title
    title.titleize
  end

  # def to_param
  #   "#{id}-#{title}".parameterize
  # end

  # scope :recent_ten, lambda { order(created_at: :desc).limit(10) }
  def self.recent_ten
    order(created_at: :desc).limit(10)
  end
  # scope :search, lambda {|keyword| where(["title ILIKE ? OR body ILIKE ?", "%#{keyword}%", "%#{keyword}%"]) }
  def self.search(keyword)
    where(["title ILIKE ? OR body ILIKE ?", "%#{keyword}%", "%#{keyword}%"])
  end

  def like_for(user)
    likes.find_by_user_id user
  end

  def vote_for(user)
    votes.find_by_user_id user
  end

  def vote_value
    votes.up.count - votes.down.count
  end

  delegate :first_name, :last_name, to: :user, prefix: true, allow_nil: true
  # is equivalent to:
  # def user_first_name
  #   user.first_name if user
  # end
  #
  # def user_last_name
  #   user.last_name if user
  # end

  private

  def capitalize_title
    self.title.capitalize! if title
  end

  def no_monkey
    if title && title.downcase.include?("monkey")
      errors.add(:title, "No monkey please!")
    end
  end

  def set_defaults
    self.view_count ||= 0
  end

end
