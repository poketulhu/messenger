class ConversationSerializer < ActiveModel::Serializer
  attributes :participants_names

  def participants_names
    "#{object.sender.name}, #{object.recipient.name}"
  end
end