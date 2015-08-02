require "rspec"
require_relative "../hangman"

describe "Phase I" do
  describe "ComputerPlayer" do
    let(:dictionary) { ["foobar"] }
    let(:computer_player) { ComputerPlayer.new(dictionary) }

    describe "#initialize" do
      it "accepts a dictionary as an argument" do
        expect { ComputerPlayer.new(dictionary) }.not_to raise_error
      end
    end

    describe "#pick_secret_word" do
      it "returns the length of a word in the dictionary" do
        expect(computer_player.pick_secret_word).to eq(6)
      end
    end

    describe "#check_guess" do
      before(:each) { computer_player.pick_secret_word }

      it "accepts a letter as an argument" do
        expect { computer_player.check_guess("z") }.not_to raise_error
      end

      it "returns the indices of the found letters" do
        expect(computer_player.check_guess("o")).to eq([1,2]) 
      end

      it "handles an incorrect guess" do
        expect(computer_player.check_guess("y")).to eq([])
      end
    end
  end

  describe "Hangman" do
    let(:players) do
      {
        referee: double(
          "ComputerPlayer",
          pick_secret_word: 2,
          check_guess: [1]
        ),

        guesser: double(
          "ComputerPlayer",
          register_secret_length: true,
          guess: "f",
          handle_response: true
        )
      }
    end

    let(:game) { Hangman.new(players) }

    context "attribute readers" do
      describe "#guesser" do
        it "returns the game's guessing player" do
          expect(game.guesser).to be(players[:guesser])
        end
      end

      describe "#referee" do
        it "returns the game's checking player" do
          expect(game.referee).to be(players[:referee])
        end
      end

      describe "#board" do
        it "returns the current state of the 'guessed word'" do
          expect { game.board }.not_to raise_error
        end
      end
    end

    describe "#initialize" do
      it "accepts an options hash with a guesser and referee" do
        expect { Hangman.new(players) }.not_to raise_error
      end

      it "doesn't perform any setup" do
        expect(game.referee).not_to receive(:pick_secret_word)
        expect(game.guesser).not_to receive(:register_secret_length)
        game
      end
    end

    describe "#setup" do
      let(:length) { rand(5) }

      before(:each) do
        allow(game.referee).to receive(:pick_secret_word).and_return(length)
      end

      it "tells the referee to choose a secret word" do
        expect(game.referee).to receive(:pick_secret_word)

        game.setup
      end

      it "tells the guesser the length of the secret word" do
        expect(game.guesser).to receive(:register_secret_length).with(length)

        game.setup
      end

      it "sets the board to be the same length as the secret length" do
        game.setup

        expect(game.board.length).to eq(length)
      end
    end

    describe "#take_turn" do
      after(:each) do
        game.setup
        game.take_turn
      end

      it "asks the guesser for a guess" do
        expect(game.guesser).to receive(:guess)
      end

      it "has the referee check the guesser's guess" do
        guess = ("a".."z").to_a.sample # chooses a random letter
        allow(game.guesser).to receive(:guess).and_return(guess)

        expect(game.referee).to receive(:check_guess).with(guess)
      end

      it "updates the board" do
        expect(game).to receive(:update_board)
      end

      it "has the guesser handle the referee's response" do
        expect(game.guesser).to receive(:handle_response)
      end
    end
  end
end
