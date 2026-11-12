
require "test_helper"

class SubmissionTest < ActiveSupport::TestCase
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

    @submission = Submission.create!(
      student: @student,
      assignment: @assignment,
      score: 85,
      status: "submitted",
      submitted_at: Time.current
    )
  end

  test "submission harus memiliki student dan assignment" do
    submission = Submission.new

    assert_not submission.valid?
    assert_includes submission.errors.attribute_names, :student
    assert_includes submission.errors.attribute_names, :assignment
  end

  test "student tidak boleh mengumpulkan tugas yang sama dua kali" do
    duplicate = Submission.new(
      student: @student,
      assignment: @assignment,
      score: 90,
      status: "submitted"
    )

    assert_not duplicate.valid?
    assert_includes duplicate.errors.attribute_names, :student_id
  end

  test "score tidak boleh kurang dari nol" do
    @submission.score = -1

    assert_not @submission.valid?
    assert_includes @submission.errors.attribute_names, :score
  end

  test "score tidak boleh lebih dari seratus" do
    @submission.score = 101

    assert_not @submission.valid?
    assert_includes @submission.errors.attribute_names, :score
  end

  test "status hanya boleh pending submitted atau graded" do
    @submission.status = "invalid"

    assert_not @submission.valid?
    assert_includes @submission.errors.attribute_names, :status
  end

  test "student dapat melihat submissions miliknya" do
    assert_includes @student.submissions, @submission
  end

  test "assignment dapat melihat submissions miliknya" do
    assert_includes @assignment.submissions, @submission
  end

  test "submission dapat menemukan student dan assignment" do
    assert_equal @student, @submission.student
    assert_equal @assignment, @submission.assignment
  end
end
