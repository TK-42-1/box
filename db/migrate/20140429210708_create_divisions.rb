class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.integer :parent_id
      t.integer :child_id

      t.timestamps
    end
    add_index :divisions, :child_id
    add_index :divisions, :parent_id
    add_index :divisions, [:child_id, :parent_id], unique: true
  end
end
