class Tagging < ActiveRecord::Base
  attr_accessible :url_id, :topic_id

  belongs_to(
    :tag_topic,
    :class_name => "TagTopic",
    :foreign_key => :topic_id,
    :primary_key => :id
  )

  belongs_to(
    :url,
    :class_name => "ShortenedUrl",
    :foreign_key => :url_id,
    :primary_key => :id
  )



end