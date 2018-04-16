class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :device_id
			t.integer :sign_in_count
      t.datetime :current_signin_at
      t.datetime :last_signin_at
      t.string :auth_token
      t.datetime :auth_token_expires_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
