class User < ActiveRecord::Base
  attr_accessible :email

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  has_many(
    :shortened_urls,
    :class_name => "ShortenedUrl",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    :class_name => "Visit",
    :foreign_key => :visitor_id,
    :primary_key => :id
  )

  has_many(
    :visited_urls,
    :through => :visits,
    :source => :shortened_url,
    :uniq => true
  )
end