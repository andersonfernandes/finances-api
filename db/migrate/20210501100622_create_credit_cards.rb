class CreateCreditCards < ActiveRecord::Migration[6.1]
  def change
    create_table :credit_cards do |t|
      t.string :name, null: false
      t.decimal :limit, null: false
      t.integer :closing_day, null: false
      t.integer :due_day, null: false
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
