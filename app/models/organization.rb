class Organization < ApplicationRecord
  has_many :organization_users
  has_many :users, through: :organization_users
  validates :full_name, :address, presence: true, length: {maximum: 50}

  def name
    self.short_name.present? ? short_name : full_name
  end
end
