class Visit < ActiveRecord::Base
  attr_accessible :url_id, :visitor_id

  belongs_to(
    :shortened_url,
    :class_name => "ShortenedUrl",
    :foreign_key => :url_id,
    :primary_key => :id
  )

  belongs_to(
    :visitor,
    :class_name => "User",
    :foreign_key => :visitor_id,
    :primary_key => :id
  )

  def self.record_visit!(user, shortened_url)
    Visit.create!(url_id: shortened_url.id, visitor_id: user.id)
  end
end