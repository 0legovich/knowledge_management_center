class Role < ApplicationRecord
  has_many :users
  validates :label, presence: true
  scope :admin, -> {where(label: "Админ").first_or_create}
  scope :learner, -> {where(label: "Ученик").first_or_create}
  scope :teacher, -> {where(label: "Преподаватель").first_or_create}
end
