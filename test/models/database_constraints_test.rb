
require "test_helper"

class DatabaseConstraintsTest < ActiveSupport::TestCase
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

  test "database menolak NIM duplikat dengan UNIQUE constraint" do
    error = assert_raises(ActiveRecord::RecordNotUnique) do
      Student.insert_all!([
        {
          nim: @student.nim,
          name: "Mahasiswa Duplikat",
          email: "duplikat@example.com"
        }
      ])
    end

    assert_match(/index_students_on_nim/, error.message)
  end

  test "database menolak email NULL dengan NOT NULL constraint" do
    assert_raises(ActiveRecord::NotNullViolation) do
      Student.insert_all!([
        {
          nim: "2310099",
          name: "Mahasiswa Tanpa Email",
          email: nil
        }
      ])
    end
  end

  test "database menolak student_id yang tidak memiliki pasangan dengan FOREIGN KEY" do
    assert_raises(ActiveRecord::InvalidForeignKey) do
      Submission.insert_all!([
        {
          student_id: 999999,
          assignment_id: @assignment.id,
          score: 80,
          status: "submitted"
        }
      ])
    end
  end

  test "database menolak score di atas 100 dengan CHECK constraint" do
    error = assert_raises(ActiveRecord::StatementInvalid) do
      Submission.insert_all!([
        {
          student_id: @student.id,
          assignment_id: @assignment.id,
          score: 101,
          status: "graded"
        }
      ])
    end

    assert_match(/check_submission_score_range/, error.message)
  end
end
