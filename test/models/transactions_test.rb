
require "test_helper"

class TransactionsTest < ActiveSupport::TestCase
  setup do
    @course = Course.create!(
      code: "IF101",
      name: "Pemrograman Dasar"
    )

    @student = Student.create!(
      nim: "2310001",
      name: "Mahasiswa Satu",
      email: "satu@example.com"
    )

    @assignment = Assignment.create!(
      course: @course,
      title: "Tugas Pemrograman",
      description: "Latihan pemrograman",
      deadline: Date.current + 7.days
    )
  end

  test "transaction berhasil melakukan commit" do
    submission = nil

    Submission.transaction(requires_new: true) do
      submission = Submission.create!(
        student: @student,
        assignment: @assignment,
        score: 85,
        status: "submitted"
      )
    end

    assert submission.persisted?
    assert Submission.exists?(submission.id)
  end

  test "transaction melakukan rollback ketika terjadi kesalahan" do
    initial_count = Submission.count

    Submission.transaction(requires_new: true) do
      Submission.create!(
        student: @student,
        assignment: @assignment,
        score: 90,
        status: "submitted"
      )

      raise ActiveRecord::Rollback
    end

    assert_equal initial_count, Submission.count
  end
end
