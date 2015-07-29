require 'byebug'
# ## Student
# * `Student#initialize` should take a first and last name.
# * `Student#name` should return the concatenation of the student's
#   first and last name.
# * `Student#courses` should return a list of the `Course`s in which
#   the student is enrolled.
# * `Student#enroll` should take a `Course` object, add it to the
#   student's list of courses, and update the `Course`'s list of
#   enrolled students.
#     * `enroll` should ignore attempts to re-enroll a student.
# * `Student#course_load` should return a hash of departments to # of
#   credits the student is taking in that department.
#
class Student

  def initialize(first,last)
    @first_name = first.capitalize
    @last_name = last.capitalize
    @courses = []
  end

  attr_reader :first_name, :last_name, :courses
  attr_accessor :courses

  def name
    @first_name + " " + @last_name
  end

  def enroll(course)
    return if @courses.include?(course)
    raise Error "Course conflict" if has_conflict?(course)

    courses << course
    course.students << self
  end

  def course_load
    @courses.inject(Hash.new(0)) do |h,course|
      h[course.department] += course.credits
      h
    end
  end

  def has_conflict?(new_course)
    self.courses.any? {|course| course.conflicts_with?(new_course)}
  end

end
