require 'student'

describe Student do
  let(:student) { Student.new("Johnny", "Rocket") }

  describe "#initialize" do
    it "takes a first and last name" do
      expect(student.first_name).to eq("Johnny")
      expect(student.last_name).to eq("Rocket")
    end

    it "initializes courses to an empty array" do
      expect(student.courses).to eq([])
    end
  end

  describe "#name" do
    it "concatenates first and last name" do
      expect(student.name).to eq("Johnny Rocket")
    end
  end

  describe "#enroll" do
    let(:old_course) { double(:old_course) }
    let(:course_student) { double(:student) }
    let(:new_course) { double(:new_course, students: [course_student]) }

    before :each do
      student.courses.push(old_course)

      # used in conjunction with extension specs
      [old_course, new_course].each do |course|
        allow(course).to receive(:conflicts_with?)
      end

      student.enroll(new_course)
    end

    it "adds course to student's list of courses" do
      expect(student.courses).to eq([old_course, new_course])
    end

    it "updates the course's list of students" do
      expect(new_course.students).to eq([course_student, student])
    end

    it "ignores attempts to re-enroll into a course" do
      student.enroll(new_course)
      expect(student.courses).to eq([old_course, new_course])
    end
  end

  describe "#course_load" do
    it "returns a hash of department names pointing to # of credits" do
      ruby = double(:ruby_course, department: "CS", credits: 4)
      javascript = double(:js_course, department: "CS", credits: 4)
      drama = double(:drama_course, department: "Theatre", credits: 2)

      allow(student).to receive(:courses).and_return([
        ruby,
        javascript,
        drama
      ])

      expect(student.course_load).to eq({
        "CS" => 8,
        "Theatre" => 2
      })
    end
  end
end
