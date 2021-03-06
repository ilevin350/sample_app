# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  before_save { |user| user.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # / marks beginning of regex
  # \A match must occur at beginning of string
  # [\w+\-]+ matches one or more word chars, plus chars or  dash chars
  # @ matches "@" char
  # [a-z\d\-.]+ matches one or more chars in range a-z, digit (0..9), dash or dot
  # \. matches a dot
  # [a-z]+ matches one or more chars in range a-z
  # \z match must occur at end of string
  # / marks end of regex
  # i indicates case insensitive
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
