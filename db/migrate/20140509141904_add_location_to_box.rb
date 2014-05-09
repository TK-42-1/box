class AddLocationToBox < ActiveRecord::Migration
  def change
    add_column :boxes, :location_id, :string
  end
end
