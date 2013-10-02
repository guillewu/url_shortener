class CreateTagTopicTable < ActiveRecord::Migration
  def up
    create_table :tag_topics do |t|
      t.string :topic
      t.timestamps
    end
  end

  def down
    drop_table :tag_topics
  end
end
