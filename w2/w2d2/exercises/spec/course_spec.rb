require 'course'
require 'student'

describe Course do
  let(:course) { Course.new("Ruby 101", "CS", 4) }

  # Comment this line in when working on extras
  # let(:course) { Course.new("Ruby 101", "CS", 4, [:mon, :tue, :wed], 1) }

  describe "#initialize" do
    it "takes a name, department, and # of credits" do
      expect(course.name).to eq("Ruby 101")
      expect(course.department).to eq("CS")
      expect(course.credits).to eq(4)
    end

    it "initializes with an empty array of students" do
      expect(course.students).to eq([])
    end
  end

  describe "#add_student" do
    it "relies on Student#enroll" do
      student = double(:student)

      expect(student).to receive(:enroll).with(course)
      course.add_student(student)
    end

    it "doesn't add the student twice into its list of students" do
      student = Student.new("Johnny", "Rocket")
      course.add_student(student)

      expect(course.students).to eq([student])
    end
  end
end
