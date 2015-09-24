class User < ActiveRecord::Base
  has_many :posts
  belongs_to :role
  has_many :likes
  before_save { self.email = email.downcase }
  validates :username, presence: true, length: { minimum: 3, maximum: 40 }, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 105 }, uniqueness: { case_sensitive: false },
                                    format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6, maximum: 32 }, confirmation: true
  has_secure_password
  scope :check_user, ->( user_name ) { where("username = ? or email = ?", user_name, user_name) }
end
