require_relative '../student'
require_relative '../course'

describe "Extras" do
  let(:ruby) { Course.new("Ruby 101", "CS", 4, [:mon, :tue, :wed], 1) }
  let(:python) { Course.new("Python", "CS", 4, [:wed, :thurs, :fri], 1) }
  let(:drama) { Course.new("Drama", "Theatre", 2, [:mon, :wed, :fri], 5) }

  describe "Course#initialize" do
    it "also takes a set of days and a time block" do
      expect(ruby.days).to eq([:mon, :tue, :wed])
      expect(ruby.time_block).to eq(1)
    end
  end

  describe "Course#conflicts_with?" do
    it "returns true if time block conflicts on the same day" do
      expect(ruby.conflicts_with?(python)).to be true
    end

    it "returns false if no conflicts" do
      expect(ruby.conflicts_with?(drama)).to be false
    end

    it "returns false if same set of days but different time blocks" do
      js = Course.new("JavaScript", "CS", 4, [:mon, :tue, :wed], 3)
      expect(ruby.conflicts_with?(js)).to be false
    end

    it "returns false if same time block but different days" do
      ruby2 = Course.new("Ruby 102", "CS", 4, [:thurs, :fri], 1)
      expect(ruby.conflicts_with?(ruby2)).to be false
    end
  end

  describe "Student#enroll" do
    it "raises an error if course conflicts with already enrolled course" do
      student = Student.new("Johnny", "Rocket")
      allow(student).to receive(:courses).and_return([drama, ruby])

      expect { student.enroll(python) }.to raise_error
    end
  end
end
