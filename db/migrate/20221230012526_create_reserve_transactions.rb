class CreateReserveTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :reserve_transactions do |t|
      t.references :reserve, null: false, foreign_key: true
      t.references :transaction, null: false, foreign_key: true

      t.timestamps
    end
  end
end
