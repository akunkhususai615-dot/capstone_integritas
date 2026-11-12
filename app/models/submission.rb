
class Submission < ApplicationRecord
  belongs_to :student
  belongs_to :assignment

  validates :student_id, uniqueness: {
    scope: :assignment_id,
    message: "sudah mengumpulkan tugas ini"
  }

  validates :score,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    allow_nil: true

  validates :status,
    inclusion: {
      in: %w[pending submitted graded]
    }
end
