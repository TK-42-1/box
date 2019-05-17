class AddDestroyedAtToBox < ActiveRecord::Migration
  def self.up
    return if ActiveRecord::Base.connection.column_exists?(:boxes, :destroyed_at)
    add_column :boxes, :destroyed_at, :datetime
  end

  def self.down
    remove_column :boxes, :destroyed_at
  end
end
