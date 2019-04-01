# == Schema Information
#
# Table name: expenses
#
#  id             :bigint(8)        not null, primary key
#  amount         :decimal(, )      not null
#  description    :string           not null
#  payment_method :integer          not null
#  spent_on       :date             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :bigint(8)
#  user_id        :bigint(8)
#
# Indexes
#
#  index_expenses_on_category_id  (category_id)
#  index_expenses_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#

class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :category

  enum payment_method: %i[debit credit_card money]

  validates :amount, numericality: true
  validates :amount, :description, :payment_method, :spent_on, presence: true

  delegate :to_response, to: :category, prefix: true

  def to_response
    exposed_fields = %i[id
                        description
                        amount
                        spent_on
                        payment_method]
    as_json(only: exposed_fields)
      .merge('category' => category_to_response)
  end
end
