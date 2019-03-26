class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.string :description, null: false
      t.decimal :amount, null: false
      t.date :spent_on, null: false
      t.integer :payment_method, null: false
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
