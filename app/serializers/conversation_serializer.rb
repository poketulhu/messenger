class ConversationSerializer < ActiveModel::Serializer
  attributes :participants_names, :unread_count

  def participants_names
    [object.sender.name, object.recipient.name]
  end

  def unread_count
    object.unread
  end
end