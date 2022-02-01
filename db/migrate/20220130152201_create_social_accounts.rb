class CreateSocialAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :social_accounts, id: :uuid do |t|
      t.string :account_name
      t.string :account_url
      t.string :logo_url
      t.uuid :user_id
      t.timestamps
    end
    add_index :social_accounts, :user_id
  end
end
