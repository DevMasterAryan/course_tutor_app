class Course < ApplicationRecord
  has_many :tutors, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :duration_hours, presence: true, numericality: { greater_than: 0 }

  accepts_nested_attributes_for :tutors, allow_destroy: true
end
