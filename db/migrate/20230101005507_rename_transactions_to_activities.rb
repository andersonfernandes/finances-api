class RenameTransactionsToActivities < ActiveRecord::Migration[7.0]
  def change
    rename_table :transactions, :activities

    rename_column :reserve_transactions, :transaction_id, :activity_id
    rename_column :credit_card_transactions, :transaction_id, :activity_id

    rename_table :reserve_transactions, :reserve_activities
    rename_table :credit_card_transactions, :credit_card_activities
  end
end
