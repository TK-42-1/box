class AddCompanyDepartmentToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :company, :int
    add_column :boxes, :department, :int
  end
end
