class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.string :auth_key
      t.integer :auth_expires_at

      t.timestamps
    end
  end
end
