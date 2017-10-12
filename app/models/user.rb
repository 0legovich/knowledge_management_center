class User < ApplicationRecord
  belongs_to :role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true, length: {maximum: 25}
  validates :role, presence: true

  before_validation :set_role, on: :create

  def set_role
    self.role = Role.learner
  end

  def name
    "#{self.first_name} #{self.last_name} #{self.patronymic}"
  end
  def short_name
    "#{self.last_name} #{self.first_name.first}. "
  end

  def sex_label
    sex ? "мужской" : "женский"
  end

  def admin?
    self.role.id == 1 unless self.role.blank?
  end

  def teacher?
    self.role == Role.teacher unless self.role.blank?
  end

  def learner?
    self.role = Role.learner unless self.role.blank?
  end
end
