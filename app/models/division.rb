class Division < ApplicationRecord
  belongs_to :organization
  has_many :division_users
  has_many :users, through: :division_users

  validates :name, :organization_id, presence: true
end
