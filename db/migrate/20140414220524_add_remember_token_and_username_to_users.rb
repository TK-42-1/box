class AddRememberTokenAndUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remember_token, :string
    add_index :users, :remember_token
    add_column :users, :username, :string
    add_index :users, :username
  end
end
