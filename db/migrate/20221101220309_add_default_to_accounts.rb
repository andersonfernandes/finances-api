class AddDefaultToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :default, :boolean, default: false
  end
end
