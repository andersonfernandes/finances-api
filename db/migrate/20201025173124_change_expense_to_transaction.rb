class ChangeExpenseToTransaction < ActiveRecord::Migration[6.0]
  def change
    rename_table :expenses, :transactions
  end
end
