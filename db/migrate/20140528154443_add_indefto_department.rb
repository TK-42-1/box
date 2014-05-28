class AddIndeftoDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :indef, :string 
  end
end
