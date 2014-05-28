class RenameDestroyToRetain < ActiveRecord::Migration
  def change
    rename_column :departments, :destroy, :retain
  end
end
