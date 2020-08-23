class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :financial_institution, null: false
      t.string :description
      t.decimal :initial_amount, null: false, default: 0.0
      t.integer :account_type, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
