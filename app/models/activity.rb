# == Schema Information
#
# Table name: activities
#
#  id          :bigint(8)        not null, primary key
#  amount      :decimal(, )      not null
#  description :string           not null
#  expires_at  :datetime
#  origin      :integer          not null
#  paid_at     :date
#  recurrent   :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint(8)
#  user_id     :bigint(8)        not null
#
# Indexes
#
#  index_activities_on_category_id  (category_id)
#  index_activities_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true

  enum origin: %i[reserve credit_card]

  validates :amount, numericality: true
  validates :amount, :description, :origin, presence: true

  delegate :id, :description, :to_response, to: :category, prefix: true

  def to_response
    exposed_fields = %i[id description amount recurrent]

    as_json(only: exposed_fields)
      .merge('category' => category_to_response,
             'paid_at' => paid_at.to_time.iso8601,
             'expires_at' => expires_at&.to_time&.iso8601)
  end
end
