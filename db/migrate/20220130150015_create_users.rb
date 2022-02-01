class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :username
      t.bigint :phone
      t.text :about
      t.string :access_token
      t.boolean :email_verified, default: false
      t.boolean :phone_verified, default: false
      t.timestamps
    end
    add_index :users, :email,    unique: true
    add_index :users, :username, unique: true
    add_index :users, :phone,   unique: true
    add_index :users, :access_token
  end
end
