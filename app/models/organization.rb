class Organization < ApplicationRecord
  has_many :divisions
  has_many :organization_users
  has_many :users, through: :organization_users

  validates :full_name, :address, presence: true, length: {maximum: 255}

  def name
    self.short_name.present? ? short_name : full_name
  end
end
