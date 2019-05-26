class CreateTracerPlusInfos < ActiveRecord::Migration
  def change
    create_table :tracer_plus_infos do |t|
      t.integer :box_code
      t.integer :warehouse_code
      t.timestamp :destroyed_at
      t.string :username

      t.timestamps
    end
  end
end
