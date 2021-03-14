class RemoveFinancialInstitutionFromAccount < ActiveRecord::Migration[6.0]
  def change
    remove_column :accounts, :financial_institution
  end
end
