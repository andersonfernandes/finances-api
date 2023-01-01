# == Schema Information
#
# Table name: reserve_activities
#
#  id          :bigint(8)        not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  activity_id :bigint(8)        not null
#  reserve_id  :bigint(8)        not null
#
# Indexes
#
#  index_reserve_activities_on_activity_id  (activity_id)
#  index_reserve_activities_on_reserve_id   (reserve_id)
#
# Foreign Keys
#
#  fk_rails_...  (activity_id => activities.id)
#  fk_rails_...  (reserve_id => reserves.id)
#
class ReserveActivity < ApplicationRecord
  belongs_to :reserve
  belongs_to :activity
end
