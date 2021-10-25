require "./spec_helper.rb"
require '../new_3_day.rb'
require 'pry'


describe TreeCalc do

  include TreeCalc

  describe "#return_x_pos" do
    it "returns 0 when passed an index of 1" do
      index = return_x_pos(1)
      expect(index).to eq(0)
    end

    it "returns 30 when passed an index of 31" do
      index = return_x_pos(31)
      expect(index).to eq(30)
    end

    it "returns 0 when passed an index of 32" do
      index = return_x_pos(32)
      expect(index).to eq(0)
    end

  end

  describe "hits_a_tree?" do
    let(:slope_line_1) { "..##.........##.........##.........##.........##.........##.......\n" }
    let(:slope_line_2) { "#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..\n" } 
    let(:slope_line_3) { ".#....#..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.\n" }
    let(:slope_line_7) { ".#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#\n"}
    let(:last_line) {".#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#\n"}

    it "returns false when idx 0 on first line of prompt example line 1" do
      result = hits_a_tree?(0, slope_line_1)
      expect(result).to eq(false)
    end

    it "returns false with an index of idx 3 line 2" do 
      result = hits_a_tree?(3, slope_line_2)
      expect(result).to eq(false)
    end

    it "returns true with an index of idx 6 line 3" do 
      result = hits_a_tree?(6, slope_line_3)
      expect(result).to eq(true)
    end

    it "returns false with an index of idx 18 line 7" do 
      result = hits_a_tree?(18, slope_line_7)
      expect(result).to eq(false)
    end

    it "returns true when an idx of __ last line" do
      result = hits_a_tree?(30, last_line)
      expect(result).to eq(true)
    end
  end

  describe "tree_calc" do 
    it "returns a tree count of 7 when moving 3 right down 1 with slope example on prompt" do
      result = tree_calc('slope', 3, 1)
      expect(result).to eq(7)
    end

    it "returns a tree count of 2 when moving 1 right down 2 with slope example on prompt" do
      result = tree_calc('slope', 1, 2)
      expect(result).to eq(2)
    end
  end
end
