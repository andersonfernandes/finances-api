class Category < ApplicationRecord
  has_and_belongs_to_many :users

  validates :description, presence: true
end
