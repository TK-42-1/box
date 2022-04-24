class ChangeWarehouseCodeToString < ActiveRecord::Migration
  def change
    change_column :tracer_plus_infos, :warehouse_code, :string
  end
end
