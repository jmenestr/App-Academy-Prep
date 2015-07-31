require_relative "../board"

describe "Board" do
  let(:board) { Board.new }

  describe "#grid" do
    it "should expose the board's @grid instance variable" do
      ivar = board.instance_variable_get(:@grid)

      expect(board.grid).to be(ivar)
    end
  end

  describe "initialize" do
    context "when passed a grid argument" do
      it "sets the board's grid to the value passed in" do
        grid = [[1, 2], [3, 4]]
        board = Board.new(grid)

        expect(board.grid).to be(grid)
      end
    end

    context "when no grid is passed in" do
      it "creates a 3 by 3 grid of nil values" do
        expect(board.grid.length).to eq(3)
        board.grid.each do |row|
          expect(row.length).to eq(3)
          expect(row.all?(&:nil?)).to be_truthy
        end
      end
    end
  end

  describe "place_mark(pos, mark)" do
    it "should change the value of a square" do
      board.place_mark([0, 0], :X)

      expect(board.grid[0][0]).to eq(:X)
    end
  end

  describe "empty?" do
    context "when the square is empty" do
      it "returns true" do
        expect(board.empty?([0, 0])).to be_truthy
      end
    end

    context "when the square is marked" do
      it "returns false" do
        place_marks([[0, 0]], :X)

        expect(board.empty?([0, 0])).to be_falsey
      end
    end
  end

  describe "winner" do
    context "when :X has won" do
      context "on a row" do
        it "returns :X" do
          place_marks([[0, 0], [0, 1], [0, 2]], :X)

          expect(board.winner).to be :X
        end
      end

      context "on the left diagonal" do
        it "returns :X" do
          place_marks([[0, 0], [1, 1], [2, 2]], :X)

          expect(board.winner).to be :X
        end
      end

      context "on the right diagonal" do
        it "returns :X" do
          place_marks([[0, 2], [1, 1], [2, 0]], :X)

          expect(board.winner).to be :X
        end
      end
    end

    context "when :O has won a column" do
      it "returns :O" do
        place_marks([[0, 2], [1, 2], [2, 2]], :O)

        expect(board.winner).to be :O
      end
    end

    context "when there is no winner" do
      it "returns nil" do
        expect(board.winner).to be nil

        fill_cats_game

        expect(board.winner).to be nil
      end
    end
  end

  describe "over?" do
    context "when the board is empty" do
      it "returns false" do
        expect(board.over?).to be_falsey
      end
    end

    context "when the board is in progress" do
      it "returns false" do
        place_marks([[0, 0], [0, 1]], :X)
        place_marks([[0, 2]], :O)

        expect(board.over?).to be_falsey
      end
    end

    context "when the game is won" do
      it "returns true" do
        place_marks([[0, 0], [0, 1], [0, 2]], :X)

        expect(board.over?).to be_truthy
      end
    end

    context "when the game is tied" do
      it "returns true" do
        fill_cats_game

        expect(board.over?).to be_truthy
      end
    end
  end
end

# spec helper methods

def place_marks(marks, sym)
  marks.each { |pos| board.place_mark(pos, sym) }
end

def fill_cats_game
  [[0, 0], [1, 1], [1, 2], [2, 1]].each do |pos|
    board.place_mark(pos, :X)
  end

  [[0, 1], [0, 2], [1, 0], [2, 0], [2, 2]].each do |pos|
    board.place_mark(pos, :O)
  end
end
