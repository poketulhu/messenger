class UserSerializer < ActiveModel::Serializer
  # Attributes we want to see in our JSON
  attributes :name, :is_online

  def is_online
    object.online?
  end
end