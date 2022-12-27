class CreateReserves < ActiveRecord::Migration[7.0]
  def change
    create_table :reserves do |t|
      t.string :description
      t.decimal :initial_amount, default: 0.0
      t.decimal :current_amount, default: 0.0
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
