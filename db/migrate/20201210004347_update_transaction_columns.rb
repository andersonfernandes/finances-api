class UpdateTransactionColumns < ActiveRecord::Migration[6.0]
  def change
    change_table :transactions do |t|
      t.rename :spent_on, :spent_at
      t.rename :payment_method, :transaction_type
      t.references :account, null: false, foreign_key: true
    end

    remove_foreign_key :transactions, :users
    remove_column :transactions, :user_id
  end
end
