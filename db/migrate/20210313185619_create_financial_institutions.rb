class CreateFinancialInstitutions < ActiveRecord::Migration[6.0]
  def change
    create_table :financial_institutions do |t|
      t.string :name, null: false
      t.string :logo_url

      t.timestamps
    end
  end
end
