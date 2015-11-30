class Message < ActiveRecord::Base
  validates :body, presence: true

  belongs_to :conversation
  belongs_to :user

  update_index 'messages#message', :self

  scope :deleted, -> do
    where("deleted=FALSE")
  end

  def mark_as_deleted(user)
    self.deleted = true unless self.user_id != user.id
  end
end