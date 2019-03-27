# == Schema Information
#
# Table name: categories
#
#  id          :bigint(8)        not null, primary key
#  description :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Category < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :expenses

  validates :description, presence: true
end
