class AddShortenedUrlsIndicesAndVisitTable < ActiveRecord::Migration
  def up
    add_index :shortened_urls, :long_url, :unique => true
    add_index :shortened_urls, :short_url, :unique => true
    create_table :visits do |t|
      t.integer :url_id
      t.integer :visitor_id
    end
    add_index :visits, :url_id, :unique => true
    add_index :visits, :visitor_id, :unique => true
  end

  def down
    remove_index :shortened_urls, :long_url
    remove_index :shortened_urls, :short_url
    drop_table :visits
    remove_index :visits, :url_id
    remove_index :visits, :visitor_id
  end
end
