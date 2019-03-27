class CreateBudgetItems < ActiveRecord::Migration[5.2]
  def change
    create_table :budget_items do |t|
      t.string :description, null: false
      t.decimal :amount, null: false
      t.decimal :min_amount, null: false
      t.references :budget, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
