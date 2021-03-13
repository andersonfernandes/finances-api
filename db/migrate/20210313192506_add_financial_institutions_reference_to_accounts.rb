class AddFinancialInstitutionsReferenceToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_reference :accounts, :financial_institution, null: false, foreign_key: true
  end
end
