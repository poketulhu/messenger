class Message < ActiveRecord::Base
  validates :body, presence: true

  belongs_to :conversation
  belongs_to :user
end