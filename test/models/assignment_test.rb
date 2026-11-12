
require "test_helper"

class AssignmentTest < ActiveSupport::TestCase
  setup do
    @course = Course.create!(
      code: "IF101",
      name: "Pemrograman Dasar"
    )

    @assignment = Assignment.create!(
      course: @course,
      title: "Tugas Pemrograman",
      description: "Latihan pemrograman",
      deadline: Date.current + 7.days
    )
  end

  test "assignment harus memiliki course, judul, dan deadline" do
    assignment = Assignment.new

    assert_not assignment.valid?
    assert_includes assignment.errors.attribute_names, :course
    assert_includes assignment.errors.attribute_names, :title
    assert_includes assignment.errors.attribute_names, :deadline
  end

  test "judul assignment wajib diisi" do
    assignment = Assignment.new(
      course: @course,
      deadline: Date.current + 7.days
    )

    assert_not assignment.valid?
    assert_includes assignment.errors.attribute_names, :title
  end

  test "deadline assignment wajib diisi" do
    assignment = Assignment.new(
      course: @course,
      title: "Tugas Baru"
    )

    assert_not assignment.valid?
    assert_includes assignment.errors.attribute_names, :deadline
  end

  test "assignment dapat menemukan course pemiliknya" do
    assert_equal @course, @assignment.course
  end

  test "course dapat melihat assignments miliknya" do
    assert_includes @course.assignments, @assignment
  end
end
