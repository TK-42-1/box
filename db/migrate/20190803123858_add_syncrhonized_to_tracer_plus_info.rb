class AddSyncrhonizedToTracerPlusInfo < ActiveRecord::Migration
  def change
    add_column :tracer_plus_infos, :synchronized, :boolean, default: false, null: false
  end
end
