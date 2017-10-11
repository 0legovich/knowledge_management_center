class User < ApplicationRecord
  belongs_to :role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :email, presence: true, length: {maximum: 25}
  validates :sex, :role, presence: true

  before_validation :set_role, on: :create

  def set_role
    self.role = Role.first
  end

  def name
    "#{self.first_name} #{self.last_name} #{self.patronymic}"
  end

  def admin?
    self.role.id == 1 unless self.role.blank?
  end
  def teacher?
    self.role.id == 2 unless self.role.blank?
  end
  def learner?
    self.role.id == 3 unless self.role.blank?
  end
end
