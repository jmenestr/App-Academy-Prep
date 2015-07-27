class Course
  attr_reader :department, :name, :credits, :time_block, :days, :students

  def initialize(name, department, credits, days, time_block)
    @name, @department, @credits, @days, @time_block =
      name, department, credits, days, time_block
    @students = []
  end

  def conflicts_with?(course2)
    return false if self.time_block != course2.time_block

    days.any? do |day|
      course2.days.include?(day)
    end
  end

  def add_student(student)
    student.enroll(self)
  end
end
