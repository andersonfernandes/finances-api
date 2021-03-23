class CreateRefreshTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :refresh_tokens do |t|
      t.string :token, null: false
      t.integer :status, null: false
      t.timestamp :revoked_at
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :refresh_tokens, :token, unique: true
  end
end
