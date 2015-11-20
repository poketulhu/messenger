class User < ActiveRecord::Base

  validates :name, presence: true

  has_many :conversations, :foreign_key => :sender_id
  has_many :messages

  has_secure_password
  validates :password, length: { minimum: 6 }
end