class AddLocationIdToBoxes < ActiveRecord::Migration
  def change
    rename_column :boxes, :location_id, :location_code
  end
end