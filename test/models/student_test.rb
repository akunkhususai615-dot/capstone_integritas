
require "test_helper"

class StudentTest < ActiveSupport::TestCase
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

  test "student harus memiliki NIM, nama, dan email" do
    student = Student.new

    assert_not student.valid?
    assert_includes student.errors.attribute_names, :nim
    assert_includes student.errors.attribute_names, :name
    assert_includes student.errors.attribute_names, :email
  end

  test "NIM tidak boleh duplikat" do
    student = Student.new(
      nim: @student.nim,
      name: "Mahasiswa Baru",
      email: "baru@example.com"
    )

    assert_not student.valid?
    assert_includes student.errors.attribute_names, :nim
  end

  test "email tidak boleh duplikat" do
    student = Student.new(
      nim: "2310002",
      name: "Mahasiswa Baru",
      email: @student.email
    )

    assert_not student.valid?
    assert_includes student.errors.attribute_names, :email
  end

  test "format email harus valid" do
    student = Student.new(
      nim: "2310003",
      name: "Mahasiswa Baru",
      email: "email-salah"
    )

    assert_not student.valid?
  end

  test "student dapat melihat submissions miliknya" do
    assert_includes @student.submissions, @submission
  end

  test "submission dapat menemukan student pemiliknya" do
    assert_equal @student, @submission.student
  end
end
