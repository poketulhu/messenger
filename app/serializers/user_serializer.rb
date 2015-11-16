class UserSerializer < ActiveModel::Serializer
  # Attributes we want to see in our JSON
  attributes :id, :name
end