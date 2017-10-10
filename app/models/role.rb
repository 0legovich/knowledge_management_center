class Role < ApplicationRecord
  has_many :users
  validates :label, presence: true
end
