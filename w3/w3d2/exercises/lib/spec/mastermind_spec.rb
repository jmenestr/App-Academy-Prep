require 'rspec'
require_relative '../mastermind'

describe Code do
  let(:blue_code_caps) { Code.parse("BBBB") }
  let(:blue_code) { Code.parse("bbbb") }

  let(:orange_code) { Code.parse("oooo") }
  let(:code1) { Code.parse("yyyb") }
  let(:code2) { Code.parse("bboy") }


  describe "::PEGS" do
    it "should be a hash of key/value pairs" do
      expect(Code::PEGS).to be_instance_of(Hash)
    end
  end

  describe "::parse" do
    context "when given a string of valid colors" do
      it "it accepts upper case input" do
        expect(blue_code_caps).to be_instance_of(Code)
      end

      it "it accepts lower case input" do
        expect(blue_code).to be_instance_of(Code)
      end
    end

    context "when given a string containing invalid colors" do
      it "raises an error" do
        expect { Code.parse("abcd") }.to raise_error
      end
    end
  end

  describe "::random" do
    it "should return an instance of Code" do
      expect(Code.random).to be_instance_of(Code)
    end
  end

  describe "#initialize" do
    it "requires an array of pegs to be passed as an argument" do
      expect { Code.new }.to raise_error(ArgumentError)
    end

    it "set the pegs array as an instance variable" do
      pegs = ["b", "b", "b", "b"]
      code = Code.new(pegs)

      expect(code.pegs).to eq(pegs)
    end
  end

  describe "#[]" do
    it "should index into Code#pegs" do
      pegs = [blue_code[0], blue_code[1], blue_code[2], blue_code[3]]

      expect(pegs).to eq(blue_code.pegs)
    end
  end

  describe "#exact_matches" do
    context "when none of the correct colors appear" do
      it "returns 0" do
        expect(blue_code.exact_matches(orange_code)).to eq(0)
      end
    end

    context "when the correct colors appear in the wrong positions" do
      it "returns 0" do
        expect(code1.exact_matches(code2)).to eq(0)
      end
    end

    context "when the correct colors appear in the correct positions" do
      it "returns the number of matches" do
        expect(orange_code.exact_matches(code2)).to eq(1)
      end
    end
  end

  describe "#near_matches" do
    it "counts near matches" do
      expect(code1.near_matches(code2)).to eq(2)
    end

    it "does not count exact matches" do
      expect(orange_code.near_matches(code2)).to eq(0)
    end
  end

  describe "#==" do
    context "when passed a non-Code object" do
      it "returns false" do
        expect(blue_code == "bbbb").to be_falsey
      end
    end

    context "when passed a non-matching Code" do
      it "returns false" do
        expect(orange_code == code1).to be_falsey
      end
    end

    it "returns true when passed a matching Code" do
      expect(blue_code_caps == blue_code).to be_truthy
    end
  end
end

describe Game do
  let(:code) { Code.parse("BBBB") }

  describe "#initialize" do
    context "when passed a secret code argument" do
      let(:game) { Game.new(code) }

      it "sets the secret code" do
        expect(game.secret_code).to eq(code)
      end
    end

    context "when no arguments are passed" do
      let(:game) { Game.new }

      it "sets the code randomly" do
        expect(Code).to receive(:random).and_call_original
        expect(game.secret_code).to be_instance_of(Code)
      end
    end
  end

  describe "input/output" do
    let(:game) { Game.new }

    before(:each) do
      $stdin = StringIO.new("bgry\n")
      $stdout = StringIO.new
    end

    describe "#get_guess" do
      it "should parse input and return Code object" do
        expect(game.get_guess).to be_instance_of(Code)
      end
    end

    describe "#display_matches" do
      it "should print near and exact matches" do
        game.display_matches(code)

        expect($stdout.string).to match(/exact/)
        expect($stdout.string).to match(/near/)
      end
    end
  end
end
