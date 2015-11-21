require 'securerandom'

class User < ActiveRecord::Base

  validates :name, presence: true

  has_many :conversations, :foreign_key => :sender_id
  has_many :messages

  #has_secure_password
  #validates :password, length: { minimum: 6 }

  before_create :set_auth_token

  private
    def set_auth_token
      return if auth_token.present?
      self.auth_token = generate_auth_token
    end

    def generate_auth_token
      SecureRandom.uuid.gsub(/\-/,'')
    end
end