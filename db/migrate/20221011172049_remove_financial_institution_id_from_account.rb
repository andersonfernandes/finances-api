class RemoveFinancialInstitutionIdFromAccount < ActiveRecord::Migration[7.0]
  def change
    remove_column :accounts, :financial_institution_id
  end
end
