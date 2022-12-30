class UpdateTransactionsColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :transactions, :spent_at, :paid_at
    remove_column :transactions, :transaction_type
    remove_column :transactions, :account_id
    add_column :transactions, :recurrent, :boolean, default: false
    add_column :transactions, :expires_at, :timestamp
    add_reference :transactions, :user, null: false, foreign_key: true
  end
end
