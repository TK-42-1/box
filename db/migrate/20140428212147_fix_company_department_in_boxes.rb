class FixCompanyDepartmentInBoxes < ActiveRecord::Migration
  def change
    rename_column :boxes, :company, :company_id
    rename_column :boxes, :department, :department_id
  end
end
