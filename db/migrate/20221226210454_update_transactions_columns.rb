class UpdateTransactionsColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :transactions, :spent_at, :paid_at
    remove_column :transactions, :transaction_type
    add_column :transactions, :recurrent, :boolean, default: false
    add_column :transactions, :expires_at, :timestamp
  end
end
