require_relative "../00_array_extensions"

describe Array do
  describe "#sum" do
    it "has a #sum method" do
      expect([]).to respond_to(:sum)
    end

    it "should be 0 for an empty array" do
      expect([].sum).to eq(0)
    end

    it "should add all of the elements" do
      expect([1,2,4].sum).to eq(7)
    end
  end

  describe "#square" do
    it "does nothing to an empty array" do
      expect([].square).to eq([])
    end

    it "returns a new array containing the squares of each element" do
      expect([1,2,3].square).to eq([1,4,9])
    end
  end

  describe "#square!" do
    it "squares each element of the original array" do
      array = [1,2,3]
      array.square!
      expect(array).to eq([1,4,9])
    end
  end

  describe "#my_uniq" do
    let(:array) { [1, 2, 1, 3, 4, 2] }

    it "returns the unique elements" do
      expect(array.my_uniq).to eq([1, 2, 3, 4])
    end

    it "does not modify the original array" do
      duped_array = array.dup

      array.my_uniq

      expect(array).to eq(duped_array)
    end

    it "does not call the built-in #uniq method" do
      expect(array).not_to receive(:uniq)

      array.my_uniq
    end
  end

  describe "#two_sum" do
    it "returns positions of pairs of numbers that add to zero" do
      expect([5, 1, -7, -5].two_sum).to eq([[0, 3]])
    end

    it "finds multiple pairs" do
      expect([5, -1, -5, 1].two_sum).to eq([[0, 2], [1, 3]])
    end

    it "finds pairs with same element" do
      expect([5, -5, -5].two_sum).to eq([[0, 1], [0, 2]])
    end

    it "returns [] when no pair is found" do
      expect([5, 5, 3, 1].two_sum).to eq([])
    end

    it "won't find spurious zero pairs" do
      expect([0, 1, 2, 3].two_sum).to eq([])
    end

    it "will find real zero pairs" do
      expect([0, 1, 2, 0].two_sum).to eq([[0, 3]])
    end
  end

  describe "#my_transpose" do
    let(:arr) { [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ] }

    let(:small_arr) { [
      [1, 2],
      [3, 4]
    ] }

    it "transposes a small matrix" do
      expect(small_arr.my_transpose).to eq([
        [1, 3],
        [2, 4]
      ])
    end

    it "transposes a larger matrix" do
      expect(arr.my_transpose).to eq([
        [1, 4, 7],
        [2, 5, 8],
        [3, 6, 9]
      ])
    end

    it "should not modify the original array" do
      small_arr.my_transpose

      expect(small_arr).to eq([
        [1, 2],
        [3, 4]
      ])
    end

    it "should not call the built-in #transpose method" do
      expect(arr).not_to receive(:transpose)

      arr.my_transpose
    end
  end

  describe "#median" do
    let(:even_array) { [3, 2, 6, 7] }
    let(:odd_array) { [3, 2, 6, 7, 1] }

    it "returns nil for the empty array" do
      expect([].median).to be_nil
    end

    it "returns the element for an array of length 1" do
      expect([1].median).to eq(1)
    end

    it "returns the median of an odd-length array" do
      expect(odd_array.median).to eq(3)
    end

    it "returns the median of an even-length array" do
      expect(even_array.median).to eq(4.5)
    end
  end
end
