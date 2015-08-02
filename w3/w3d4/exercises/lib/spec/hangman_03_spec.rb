require "rspec"
require_relative "../hangman"

describe "Phase III" do
  describe "ComputerPlayer" do
    let(:dictionary) { ["foo", "bar", "foobar"] }
    let(:computer_player) { ComputerPlayer.new(dictionary) }

    describe "#candidate_words" do
      it "returns the list of words not yet eliminated from the dictionary" do
        expect { computer_player.candidate_words }.not_to raise_error
      end
    end

    describe "#register_secret_length" do
      it "rejects words of the wrong length from #candidate_words" do
        computer_player.register_secret_length(3)

        expect(computer_player.candidate_words).to contain_exactly("foo", "bar")
      end
    end

    describe "#handle_response" do
      before(:each) { computer_player.register_secret_length(3) }

      context "when the guessed letter is found at some indices" do
        it "rejects non-matching words from #candidate_words" do
          computer_player.handle_response("o", [1, 2])

          expect(computer_player.candidate_words).to eq(["foo"])
        end
      end

      context "when the guessed letter is found at no indices" do
        it "rejects words containing the guessed letter from #candidate_words" do
          computer_player.handle_response("f", [])

          expect(computer_player.candidate_words).to eq(["bar"])
        end
      end

      it "correctly handles the response after registering secret length" do
        guesser = ComputerPlayer.new(["leer", "reel", "real", "rear"])
        guesser.register_secret_length(4)

        guesser.handle_response("r", [0])

        expect(guesser.candidate_words.sort).to eq(["reel","real"].sort)
      end
    end

    describe "#guess" do
      let(:guesser) { ComputerPlayer.new(["reel","keel","meet"]) }
      before(:each) { guesser.register_secret_length(4) }

      context "when no guesses have been made" do
        it "returns the most common letter in #candidate_words" do
          board = [nil, nil, nil, nil]

          expect(guesser.guess(board)).to eq("e")
        end
      end

      context "when a guess has been made" do
        it "returns the most common letter in the remaining #candidate_words" do
          board = [nil, "e", "e", nil]

          expect(guesser.guess(board)).to eq("l")
        end
      end
    end
  end
end
