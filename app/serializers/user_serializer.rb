class UserSerializer < ActiveModel::Serializer
  attributes :name, :is_online

  def is_online
    object.online?
  end
end