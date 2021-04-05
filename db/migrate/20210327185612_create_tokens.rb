class CreateTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens do |t|
      t.string :jwt_id, null: false
      t.integer :status, null: false
      t.timestamp :expiry_at, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tokens, :jwt_id, unique: true
  end
end
