class TagTopic < ActiveRecord::Base
  attr_accessible :topic

  has_many(
    :taggings,
    :class_name => "Tagging",
    :foreign_key => :topic_id,
    :primary_key => :id
  )

  has_many(
    :urls,
    :through => :taggings,
    :source => :url
  )

  def most_popular
    most_popular = {}
    self.urls.each do |url|
      most_popular[url.long_url] = url.num_clicks
    end

    most_popular.sort_by {|url, view_count| view_count}
  end
end