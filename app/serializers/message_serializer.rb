require "uri"

class MessageSerializer < ActiveModel::Serializer
  attributes :body, :page_information, :image, :video, :created_at

  def page_information
    if URI.extract(object.body).any?
      m = MetaInspector.new(URI.extract(object.body).first)
      if m.content_type["text"]
        [m.title, m.description, m.images.best]
      end
    else
      nil
    end
  end

  def image
    object.image unless object.image_file_name?
  end

  def videos
    object.video unless object.video_file_name?
  end
end