class CreateTables < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :email

      t.timestamps
    end

    create_table :shortened_urls do |t|
      t.string :long_url
      t.string :short_url
      t.integer :submitter_id

      t.timestamps
    end
  end

  def down
    drop_table :users
    drop_table :shortened_urls
  end
end
