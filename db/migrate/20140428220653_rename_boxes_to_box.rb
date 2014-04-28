class RenameBoxesToBox < ActiveRecord::Migration
  def change
    rename_table :boxes, :box
  end
end
