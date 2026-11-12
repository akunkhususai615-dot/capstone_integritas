
require "test_helper"

class CourseTest < ActiveSupport::TestCase
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

  test "course harus memiliki kode dan nama" do
    course = Course.new

    assert_not course.valid?
    assert_includes course.errors.attribute_names, :code
    assert_includes course.errors.attribute_names, :name
  end

  test "kode course tidak boleh duplikat" do
    course = Course.new(
      code: @course.code,
      name: "Course Baru"
    )

    assert_not course.valid?
    assert_includes course.errors.attribute_names, :code
  end

  test "nama course wajib diisi" do
    course = Course.new(code: "IF102")

    assert_not course.valid?
    assert_includes course.errors.attribute_names, :name
  end

  test "course dapat melihat assignments miliknya" do
    assert_includes @course.assignments, @assignment
  end

  test "assignment dapat menemukan course pemiliknya" do
    assert_equal @course, @assignment.course
  end
end
