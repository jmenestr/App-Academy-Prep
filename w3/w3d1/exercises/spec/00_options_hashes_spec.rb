require 'rspec'
require '00_options_hashes'

describe '#transmogrify' do
  it 'should work without an options hash passed in' do
    expect { transmogrify("foobar") }.to_not raise_error
  end

  it 'should override the defaults when specified in the options hash' do
    options = { times: 3, upcase: true, reverse: true }
    expect(transmogrify("foo ", options)).to eq(' OOF OOF OOF')
  end

  it 'should not modify the options hash' do
    options = { times: 3 }
    transmogrify("test", options)
    expect(options).to eq({ times: 3 })
  end

  it 'should not modify the original string' do
    word = "foobar"
    transmogrify(word, {times: 4, upcase: true, reverse: true })
    expect(word).to eq("foobar")
  end
end

