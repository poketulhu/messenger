require "uri"

class MessageSerializer < ActiveModel::Serializer
  attributes :message_body, :created_at

  def message_body
    links = URI.extract(object.body)
    if links.any?
      m = MetaInspector.new(links.first)
      {body: object.body, link: [m.title, m.description, m.images.best]}
    else
      object.body
    end
  end
end