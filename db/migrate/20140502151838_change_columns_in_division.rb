class ChangeColumnsInDivision < ActiveRecord::Migration
  def change
    rename_column :divisions, :parent_id, :company_id
    rename_column :divisions, :child_id, :department_id
  end
end
