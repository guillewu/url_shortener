class RemoveUniquenessConstraints < ActiveRecord::Migration
  def up
    remove_index :visits, :url_id
    remove_index :visits, :visitor_id
    add_index :visits, :url_id
    add_index :visits, :visitor_id
  end

  def down
    remove_index :visits, :url_id
    remove_index :visits, :visitor_id
    add_index :visits, :url_id, :unique => true
    add_index :visits, :visitor_id, :unique => true
  end
end
