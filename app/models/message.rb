class Message < ActiveRecord::Base
  validates :body, presence: true

  belongs_to :conversation
  belongs_to :user

  update_index 'messages#message', :self

  has_attached_file :image, :styles => { :thumb => "200x200>" }
  validates_attachment :image, content_type: { content_type: ["image/jpg",
                                                              "image/jpeg",
                                                              "image/png",
                                                              "image/gif"] }

  has_attached_file :video, :styles => { :p240mp4 => { :geometry => "320x240", :format => 'mp4' },
                                         :p240webm => { :geometry => "320x240", :format => 'webm' },
                                         :p360mp4 => { :geometry => "640x360", :format => 'mp4' },
                                         :p360webm => { :geometry => "640x360", :format => 'webm' },
                                         :p480mp4 => { :geometry => "640х480", :format => 'mp4' },
                                         :p480webm => { :geometry => "640х480", :format => 'webm' },
                                         :p720mp4 => { :geometry => "1280х720", :format => 'mp4' },
                                         :p720webm => { :geometry => "1280х720", :format => 'webm' },
                                         :p1080mp4 => { :geometry => "1920x1080", :format => 'mp4'},
                                         :p1080webm => { :geometry => "1920x1080", :format => 'webm'}
                                       }
  validates_attachment :video, content_type: { content_type: ["video/mpeg",
                                                              "video/mp4",
                                                              "video/quicktime",
                                                              "video/webm",
                                                              "video/x-flv"] }

  scope :deleted, -> do
    where("deleted=FALSE")
  end

  def mark_as_deleted(user)
    self.deleted = true unless self.user_id != user.id
  end

  def image_remote_url=(url_value)
    self.image = URI.parse(url_value)
    @image_remote_url = url_value
  end

  def video_remote_url=(url_value)
    self.video = URI.parse(url_value)
    @video_remote_url = url_value
  end

  def links_processing(links)
    m = MetaInspector.new(links.first)
    if m.content_type["image"]
      self.image_remote_url=links.first
      self.save
    elsif m.content_type["video"]
      self.video_remote_url=links.first
      self.save
    else
      self.save
    end
  end
end