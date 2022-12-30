class CreateCreditCardTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :credit_card_transactions do |t|
      t.references :credit_card, null: false, foreign_key: true
      t.references :transaction, null: false, foreign_key: true

      t.timestamps
    end
  end
end
