require "rspec"
require_relative "../hangman"

describe "Phase II" do
  describe "ComputerPlayer" do
    let(:player) { ComputerPlayer.new(["foobar"]) }
    let(:board)  { [nil, nil, nil, nil, nil, nil] }

    describe "#register_secret_length" do
      it "accepts a length as an argument" do
        expect { player.register_secret_length(6) }.not_to raise_error
      end
    end

    describe "#guess" do
      before(:each) { player.register_secret_length(6) }

      it "accepts a board" do
        expect { player.guess(board) }.not_to raise_error
      end

      it "returns a letter" do
        letter = player.guess(board)

        expect(letter).to be_instance_of(String)
        expect(letter.length).to eq(1)
      end
    end

    describe "#handle_response" do
      it "should not throw an error" do
        player.register_secret_length(6)

        expect { player.handle_response("z", []) }.not_to raise_error
      end
    end
  end
end
