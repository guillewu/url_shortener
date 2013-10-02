class AddTimestampsToVisits < ActiveRecord::Migration
  def up
    add_column :visits, :created_at, :datetime
    add_column :visits, :updated_at, :datetime
  end

  def down
    remove_column :visits, :created_at
    remove_column :visits, :updated_at
  end
end
