
class Assignment < ApplicationRecord
  belongs_to :course
  has_many :submissions, dependent: :restrict_with_error

  validates :title, presence: true
  validates :deadline, presence: true
end
