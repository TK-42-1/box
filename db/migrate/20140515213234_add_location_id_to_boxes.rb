class AddLocationIdToBoxes < ActiveRecord::Migration
  def change
    add_column :box, :location_id, :string
  end
end
