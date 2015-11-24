class Conversation < ActiveRecord::Base
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'
  has_many :messages

  validates_uniqueness_of :sender_id, :scope => :recipient_id

  scope :between, -> (sender_id,recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id =?)
          OR (conversations.sender_id = ? AND conversations.recipient_id =?)",
          sender_id,recipient_id, recipient_id, sender_id)
  end

  scope :user_conversations, -> (user) do
    where("conversations.sender_id =? OR conversations.recipient_id =?",user.id,user.id)
  end

  def self.conversation_exists(params={})
    if self.between(params[:sender_id],params[:recipient_id]).present?
      conversation = self.between(params[:sender_id],params[:recipient_id]).first
    else
      conversation = self.new(params)
    end
  end
end
