class Tutor < ApplicationRecord
  belongs_to :course

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true
  validates :experience_years, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
