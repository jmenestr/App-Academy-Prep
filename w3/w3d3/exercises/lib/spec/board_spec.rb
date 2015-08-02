require "rspec"
require_relative "../board"
require "byebug"

describe Board do
  subject(:board) { Board.new }

  let(:empty_grid) { Array.new(2) { Array.new(2) } }
  let(:empty_board) { Board.new(empty_grid) }

  let(:two_ship_grid) { [[:s, :s], [nil, nil]] }
  let(:two_ship_board) { Board.new(two_ship_grid) }

  let(:full_grid) { [[:s, :s], [:s, :s]] }
  let(:full_board) { Board.new(full_grid) }

  describe "::default_grid" do
    let(:grid) { Board.default_grid }

    it "returns a 10x10 grid" do
      expect(grid.length).to eq(10)

      grid.each do |row|
        expect(row.length).to eq(10)
      end
    end
  end

  describe "#initialize" do
    context "when passed a grid" do
      it "initializes with the provided grid" do
        expect(empty_board.grid).to eq(empty_grid)
      end
    end

    context "when not passed a grid" do
      it "initializes with Board::default_grid" do
        grid = Board.default_grid

        expect(Board).to receive(:default_grid).and_call_original

        expect(board.grid).to eq(grid)
      end
    end
  end

  describe "#count" do
    it "returns the number of ships on the board" do
      expect(empty_board.count).to eq(0)
      expect(two_ship_board.count).to eq(2)
    end
  end

  describe "#empty?" do
    context "when passed a position" do
      it "returns true for an empty position" do
        expect(two_ship_board.empty?([1, 1])).to be_truthy
      end

      it "returns false for an occupied position" do
        expect(two_ship_board.empty?([0, 0])).to be_falsey
      end
    end

    context "when not passed a position" do
      context "with ships on the board" do
        it "returns false" do
          expect(two_ship_board).not_to be_empty
        end
      end

      context "with no ships on the board" do
        it "returns true" do
          expect(empty_board).to be_empty
        end
      end
    end
  end

  describe "#full?" do
    context "when the board is full" do
      it "returns true" do
        expect(full_board).to be_full
      end
    end

    context "when the board is not full" do
      it "returns false" do
        expect(two_ship_board).not_to be_full
      end
    end
  end

  describe "#place_random_ship" do
    context "when the board is full" do
      it "raises an error" do
        expect { full_board.place_random_ship }.to raise_error
      end
    end

    context "when the board is empty" do
      it "places a ship in a random position" do
        empty_board.place_random_ship

        expect(empty_board.count).to eq(1)
      end

      it "places ships until the board is full" do
        expect do
          empty_board.place_random_ship until empty_board.full?
        end.not_to raise_error
      end
    end
  end

  describe "#won?" do
    context "when no ships remain" do
      it "returns true" do
        expect(empty_board).to be_won
      end
    end

    context "when at least one ship remains" do
      it "returns false" do
        expect(two_ship_board).not_to be_won
      end
    end
  end
end
