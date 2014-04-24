class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :description
      t.string :created_by
      t.string :month
      t.string :year
      t.string :destroy_by
      t.string :stored_by

      t.timestamps
    end
  end
end
