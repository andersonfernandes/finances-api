class RemoveInitialAmountFromAccounts < ActiveRecord::Migration[7.0]
  def change
    remove_column :accounts, :initial_amount
  end
end
