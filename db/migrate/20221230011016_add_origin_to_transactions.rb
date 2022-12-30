class AddOriginToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :origin, :integer, null: false
  end
end
