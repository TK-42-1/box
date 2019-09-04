class AddErrorToTracerPlusInfo < ActiveRecord::Migration
  def change
    add_column :tracer_plus_infos, :error, :string
  end
end
