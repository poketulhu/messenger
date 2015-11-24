class UserSerializer < ActiveModel::Serializer
  # Attributes we want to see in our JSON
  attributes :name, :is_online

  def is_online
    if object.online?
      'online'
    end
  end
end