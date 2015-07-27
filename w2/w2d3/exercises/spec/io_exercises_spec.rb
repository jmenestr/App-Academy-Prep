require 'byebug'
require 'io_exercises'
require 'stringio'

class NoMoreInput < StandardError
end

describe 'guessing_game' do
  before do
    $stdout = StringIO.new
    $stdin = StringIO.new

    def gets
      result = $stdin.gets
      raise NoMoreInput unless result

      result
    end

    def recent_output
      outputs = $stdout.string.split("\n")
      max = [outputs.length, 5].min
      outputs[-max..-1].join(' ')
    end

    def guessing_game!
      guessing_game
    rescue NoMoreInput
    end
  end

  after :all do
    $stdout = STDOUT
    $stdin = STDIN
  end

  let(:guesses) { (1..100).to_a.shuffle }

  def answer
    guesses[guesses.index(gets.to_i) - 1]
  rescue NoMoreInput
    guesses.last
  end

  def num_guesses
    guesses.index(gets.to_i)
  rescue NoMoreInput
    100
  end

  it "should ask for a guess" do
    guessing_game!

    expect(recent_output.downcase).to match(/guess a number/)
  end

  it "should reprint guesses" do
    $stdin.string << "7\n"
    guessing_game!

    expect($stdout.string.downcase).to match(/7/)
  end

  it "should indicate too high" do
    10.times do
      begin
        $stdin.string = "100\n"
        guessing_game
      rescue NoMoreInput
        expect($stdout.string).to match(/too high/)
      end
    end
  end

  it "should indicate too low" do
    10.times do
      begin
        $stdin.string = "0\n"
        guessing_game
      rescue NoMoreInput
        expect($stdout.string).to match (/too low/)
      end
    end
  end

  it "should terminate with a correct guess" do
    $stdin.string = guesses.join("\n")
    guessing_game
  end

  it "shouldn't choose 0" do
    1000.times do
      $stdin.string = "0\n"
      expect { guessing_game }.to raise_error(NoMoreInput)
    end
  end

  it "should choose a number between 1 and 100" do
    1000.times do
      $stdin.string = guesses.join("\n")
      guessing_game
    end
  end

  it "should not choose the same number every time" do
    answers = []

    10.times do
      $stdin.string = guesses.join("\n")
      guessing_game
      answers << answer
    end

    expect(answers.uniq.length).to be > 1
  end

  it "should print out the correctly guessed number" do
    $stdin.string = guesses.join("\n")
    guessing_game

    expect(recent_output).to match(/#{ answer }/)
  end

  it "should print out the number of guesses" do
    $stdin.string = guesses.join("\n")
    guessing_game

    expect(recent_output).to match(/#{ num_guesses }/)
  end
end
