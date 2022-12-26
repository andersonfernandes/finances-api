class UpdateCreditCardColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :credit_cards, :closing_day
    remove_column :credit_cards, :account_id
    rename_column :credit_cards, :due_day, :billing_day
    add_reference :credit_cards, :user, null: false, foreign_key: true
  end
end
