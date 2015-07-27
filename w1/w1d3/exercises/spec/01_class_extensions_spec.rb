require "rspec"
require "01_class_extensions"

describe String do
  describe "#caesar" do
    it "encodes a simple word" do
      expect("aaa".caesar(11)).to eq("lll")
    end

    it "wraps around" do
      expect("zzz".caesar(1)).to eq("aaa")
    end

    it "encodes a longer word" do
      expect("catzhatz".caesar(2)).to eq("ecvbjcvb")
    end
  end
end

describe Hash do
  describe "#difference" do
    let(:hash) { { a: 1, b: 2 } }
    let(:overlapping_hash) { { b: 4, c: 3 } }
    let(:non_overlapping_hash) { { c: 3, d: 4 } }

    it "returns the difference of non-overlapping hashes" do
      expect(hash.difference(non_overlapping_hash)).to eq({
        a: 1,
        b: 2,
        c: 3,
        d: 4
      })
    end

    it "returns the difference of overlapping hashes" do
      expect(hash.difference(overlapping_hash)).to eq({
        a: 1,
        c: 3
      })
    end

    it "does not modify the original hashes" do
      duped_hash = hash.dup
      duped_overlapping_hash = overlapping_hash.dup

      hash.difference(overlapping_hash)

      expect(hash).to eq(duped_hash)
      expect(overlapping_hash).to eq(duped_overlapping_hash)
    end
  end
end

describe Fixnum do
  describe "#stringify" do
    it "stringifies numbers in base 10" do
      expect(5.stringify(10)).to eq("5")
      expect(10.stringify(10)).to eq("10")
      expect(42.stringify(10)).to eq("42")
    end

    it "stringifies numbers in base 2" do
      expect(5.stringify(2)).to eq("101")
      expect(10.stringify(2)).to eq("1010")
      expect(42.stringify(2)).to eq("101010")
    end

    it "stringifies numbers in base 16" do
      expect(5.stringify(16)).to eq("5")
      expect(10.stringify(16)).to eq("a")
      expect(42.stringify(16)).to eq("2a")
    end
  end
end
