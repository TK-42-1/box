class ChangeRetainToString < ActiveRecord::Migration
  def change
    change_column :departments, :retain, :string
  end
end
