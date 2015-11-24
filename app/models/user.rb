require 'securerandom'

class User < ActiveRecord::Base

  validates :name, presence: true

  has_many :conversations, :foreign_key => :sender_id
  has_many :messages

  before_create :set_auth_token

  def online?
    $redis_onlines.exists( self.id )
  end

  private
    def set_auth_token
      return if auth_token.present?
      self.auth_token = generate_auth_token
    end

    def generate_auth_token
      SecureRandom.uuid.gsub(/\-/,'')
    end
end