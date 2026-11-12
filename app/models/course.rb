
class Course < ApplicationRecord
  has_many :assignments, dependent: :restrict_with_error

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
end
