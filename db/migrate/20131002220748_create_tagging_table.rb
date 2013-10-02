class CreateTaggingTable < ActiveRecord::Migration
  def up
    create_table :taggings do |t|
      t.integer :url_id
      t.integer :topic_id
    end
  end

  def down
    drop_table :taggings
  end
end
