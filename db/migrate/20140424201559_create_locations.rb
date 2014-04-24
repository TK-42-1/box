class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :code
      t.string :room
      t.string :row
      t.string :section
      t.string :shelf
      t.string :slot

      t.timestamps
    end
  end
end
