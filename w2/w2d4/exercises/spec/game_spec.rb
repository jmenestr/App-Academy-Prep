require "game"
require "board"

describe "Game" do
  let(:player_one) { double("player", name: "Claire", mark: :X) }
  let(:player_two) { double("player", name: "Gizmo", mark: :O) }

  let(:game) do
    Game.new(player_one, player_two)
  end

  before(:each) do
    allow(player_one).to receive(:mark=)
    allow(player_two).to receive(:mark=)
  end

  describe "#board" do
    it "exposes a @board instance variable" do
      ivar = game.instance_variable_get(:@board)

      expect(game.board).to be(ivar)
      expect(game.board).to be_an_instance_of(Board)
    end
  end

  describe "#play_turn" do
    before(:each) do
      allow(player_one).to receive(:display)
      allow(player_two).to receive(:display)
      allow(player_one).to receive(:get_move).and_return([0, 0])
    end

    it "gets a move from the current player and performs it" do
      expect(player_one).to receive(:get_move).and_return(:move)
      expect(game.board).to receive(:place_mark).with(:move, :X)

      game.play_turn
    end

    it "passes the turn to the other player" do
      expect(game).to receive(:switch_players!)

      game.play_turn
    end
  end

  describe "#current_player" do
    it "starts set to the first player passed to Game.new" do
      expect(game.current_player).to be(player_one)
    end
  end

  describe "switch_players!" do
    it "updates the value of current_player" do
      expect(game.current_player).to be(player_one)

      game.switch_players!

      expect(game.current_player).to be(player_two)
    end
  end
end
