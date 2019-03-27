# == Schema Information
#
# Table name: budget_items
#
#  id          :bigint(8)        not null, primary key
#  amount      :decimal(, )      not null
#  description :string           not null
#  min_amount  :decimal(, )      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  budget_id   :bigint(8)
#  category_id :bigint(8)
#
# Indexes
#
#  index_budget_items_on_budget_id    (budget_id)
#  index_budget_items_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (budget_id => budgets.id)
#  fk_rails_...  (category_id => categories.id)
#

class BudgetItem < ApplicationRecord
  belongs_to :budget
  belongs_to :category

  validates :amount, :min_amount, numericality: true
  validates :amount, :min_amount, :description, presence: true
end
