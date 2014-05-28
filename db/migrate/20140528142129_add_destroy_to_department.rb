class AddDestroyToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :destroy, :int
  end
end
