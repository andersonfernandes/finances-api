class DropFinancialInstitutions < ActiveRecord::Migration[7.0]
  def change
    drop_table :financial_institutions
  end
end
