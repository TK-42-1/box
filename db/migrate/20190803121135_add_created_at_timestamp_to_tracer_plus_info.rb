class AddCreatedAtTimestampToTracerPlusInfo < ActiveRecord::Migration
  def change
    TracerPlusInfo.update_all(created_at: Time.now, updated_at: Time.now)
    execute 'ALTER TABLE tracer_plus_infos CHANGE created_at created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP '
  end
end
