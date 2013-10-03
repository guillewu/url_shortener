require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  attr_accessible :long_url, :short_url, :submitter_id

  validates :long_url, uniqueness: true, length: { maximum: 1024 }
  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true

  belongs_to(
    :submitter,
    :class_name => "User",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    :class_name => "Visit",
    :foreign_key => :url_id,
    :primary_key => :id
  )

  has_many(
    :visitors,
    :through => :visits,
    :source => :visitor,
    :uniq => true
  )

  has_many(
    :tag_topics,
    :through => :taggings,
    :source => :tag_topic
  )

  has_many(
    :taggings,
    :class_name => "Tagging",
    :foreign_key => :url_id,
    :primary_key => :id

  )

  def self.random_code
    code = nil
    until code
      code = SecureRandom::urlsafe_base64
      code = nil if ShortenedUrl.find_by_short_url(code)
    end
    code
  end


  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.find_by_long_url(long_url) ||
    ShortenedUrl.create!(long_url: long_url, short_url: random_code, submitter_id: user.id)
  end

  def num_clicks
    visits.size
  end

  def num_uniques
    visitors.size
  end

  def num_recent_uniques(minutes = 10)
    now = Time.now
    range = ((now - 60.minutes)..now)
    visits.where(:created_at => range).count

    # visits.select do |visit|
    #   ((Time.now - visit.created_at) / 60) <= minutes
    # end.group_by do |visit|
    #   visit.visitor
    # end.count
  end
end