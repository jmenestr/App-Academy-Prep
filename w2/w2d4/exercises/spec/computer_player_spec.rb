require "game"

describe "ComputerPlayer" do
  let(:comp) { ComputerPlayer.new("Bonzo") }
  let(:board) { Board.new }

  describe "#initialize" do
    it "sets an instance variable to the given name" do
      expect(comp.instance_variable_get(:@name)).to eq("Bonzo")
    end
  end

  describe "display" do
    it "should set the value of the `#board` instance variable" do
      comp.display(board)

      expect(comp.board).to eq(board)
    end
  end

  describe "get_move" do
    context "when a winning move is available" do
      it "should return the winning move" do
        place_marks([[0, 0], [1, 0]], :O)
        comp.mark = :O
        comp.display(board)

        expect(comp.get_move).to eq([2, 0])
      end
    end

    context "when no winning move is available" do
      it "returns a random move" do
        comp.display(board)
        pos = comp.get_move

        expect(pos).to be_an_instance_of(Array)
        expect(pos.length).to eq(2)
      end
    end
  end
end

# spec helper methods

def place_marks(marks, sym)
  marks.each { |pos| board.place_mark(pos, sym) }
end
