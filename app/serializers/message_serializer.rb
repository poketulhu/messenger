class MessageSerializer < ActiveModel::Serializer
  attributes :body, :created_at
end