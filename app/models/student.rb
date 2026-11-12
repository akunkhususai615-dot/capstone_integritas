
class Student < ApplicationRecord
  has_many :submissions, dependent: :restrict_with_error

  validates :nim, presence: true, uniqueness: true
  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }
end
