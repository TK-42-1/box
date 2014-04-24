class AddCompanyAndDepartmentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company, :string
    add_column :users, :department, :string
  end
end
