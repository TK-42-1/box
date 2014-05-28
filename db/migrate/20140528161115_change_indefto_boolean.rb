class ChangeIndeftoBoolean < ActiveRecord::Migration
  def change
    change_column :departments, :indef, :boolean
  end
end
