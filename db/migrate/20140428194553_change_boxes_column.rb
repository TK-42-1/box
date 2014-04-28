class ChangeBoxesColumn < ActiveRecord::Migration
  def change
    rename_column :boxes, :created_by, :user_id
    change_column :boxes, :user_id, :int
  end
end
