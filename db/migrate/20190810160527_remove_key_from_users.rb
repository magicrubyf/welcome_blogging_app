class RemoveKeyFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :auth_key
    remove_column :users, :auth_expires_at
  end
end
