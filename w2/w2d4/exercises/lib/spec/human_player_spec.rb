require_relative "../game"

describe "HumanPlayer" do
  let(:human) { HumanPlayer.new("Frankie") }
  let(:board) { Board.new }

  class NoMoreInput < StandardError
  end

  before do
    $stdout = StringIO.new
    $stdin = StringIO.new

    class HumanPlayer
      def gets
        result = $stdin.gets
        raise NoMoreInput unless result

        result
      end
    end

    def recent_output
      outputs = $stdout.string.split("\n")
      max = [outputs.length, 5].min
      outputs[-max..-1].join(" ")
    end

    def human.get_move!
      get_move
      rescue NoMoreInput
    end
  end

  after :all do
    $stdout = STDOUT
    $stdin = STDIN
  end

  describe "#initialize" do
    it "initializes with a name" do
      expect(human.name).to eq("Frankie")
    end
  end

  describe "#get_move" do
    it "asks for a move" do
      human.get_move!
      expect($stdout.string.downcase).to match(/where/)
    end

    it "should take an entry of the form '0, 0' and return a position" do
      $stdin.string << "0, 0"

      expect(human.get_move).to eq([0, 0])
    end
  end

  describe "#display" do
    it "prints the board to the screen" do
      board.place_mark([0, 0], :X)
      human.display(board)

      expect($stdout.string).to match(/X/)
    end
  end
end
