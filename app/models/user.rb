# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

#This is our USER MODEL - People's information will be stored here.

class User < ActiveRecord::Base
  attr_accessible :email, :username, :password, :password_confirmation
  has_secure_password
  has_many :statements, dependent: :destroy

  before_save { |user| user.email=email.downcase}
  before_save :create_remember_token

  self.per_page = 10

#Validations
	
	VALID_USERNAME_REGEX = /\A[\w+\-.]+\z/i
  validates :username, presence: true, length: {maximum: 15}, format: {with: VALID_USERNAME_REGEX}, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
