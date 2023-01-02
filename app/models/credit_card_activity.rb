# == Schema Information
#
# Table name: credit_card_activities
#
#  id             :bigint(8)        not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  activity_id    :bigint(8)        not null
#  credit_card_id :bigint(8)        not null
#
# Indexes
#
#  index_credit_card_activities_on_activity_id     (activity_id)
#  index_credit_card_activities_on_credit_card_id  (credit_card_id)
#
# Foreign Keys
#
#  fk_rails_...  (activity_id => activities.id)
#  fk_rails_...  (credit_card_id => credit_cards.id)
#
class CreditCardActivity < ApplicationRecord
  belongs_to :credit_card
  belongs_to :activity
end
