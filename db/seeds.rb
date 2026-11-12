
# ==========================================
# SEED DATA CAPSTONE INTEGRITAS
# Idempotent: aman dijalankan berulang kali
# ==========================================

# 1. Membuat mahasiswa
student1 = Student.find_or_create_by!(nim: "2310001") do |student|
  student.name = "Felix"
  student.email = "felix@example.com"
end

student2 = Student.find_or_create_by!(nim: "2310002") do |student|
  student.name = "Mahasiswa Kedua"
  student.email = "mahasiswa2@example.com"
end

# 2. Membuat mata kuliah
course1 = Course.find_or_create_by!(code: "IF101") do |course|
  course.name = "Pemrograman Dasar"
end

course2 = Course.find_or_create_by!(code: "IF102") do |course|
  course.name = "Basis Data"
end

# 3. Membuat tugas
assignment1 = Assignment.find_or_create_by!(
  course: course1,
  title: "Tugas Pemrograman"
) do |assignment|
  assignment.description = "Latihan pemrograman dasar"
  assignment.deadline = Date.current + 7.days
end

assignment2 = Assignment.find_or_create_by!(
  course: course2,
  title: "Tugas Basis Data"
) do |assignment|
  assignment.description = "Latihan database"
  assignment.deadline = Date.current + 14.days
end

# 4. Membuat pengumpulan tugas
Submission.find_or_create_by!(
  student: student1,
  assignment: assignment1
) do |submission|
  submission.score = 85
  submission.status = "submitted"
  submission.submitted_at = Time.current
end

Submission.find_or_create_by!(
  student: student2,
  assignment: assignment2
) do |submission|
  submission.score = 90
  submission.status = "graded"
  submission.submitted_at = Time.current
end

puts "Seed berhasil dijalankan!"
puts "Students: #{Student.count}"
puts "Courses: #{Course.count}"
puts "Assignments: #{Assignment.count}"
puts "Submissions: #{Submission.count}"
