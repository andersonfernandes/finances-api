# == Schema Information
#
# Table name: categories
#
#  id          :bigint(8)        not null, primary key
#  description :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint(8)
#
# Indexes
#
#  index_categories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Category < ApplicationRecord
  belongs_to :user
  has_many :expenses

  validates :description, presence: true

  def to_response
    as_json(only: %i[id description])
  end
end
