require './lib/calculator.rb'

describe Calculator do
  describe "#add" do
    it "returns the sum of two numbers" do
      calculator = Calculator.new
      expect(calculator.add(5,2)).to eql(7)
    end

    it "returns the sum of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.add(2,5,7)).to eql(14)
    end

    it "returns the sum of 10" do
      calculator = Calculator.new
      expect(calculator.add(1,2,3,4,5,6,7,8,9,10)).to eql(55)
    end
  end

  describe "#divide" do
    it "returns quotient of two numbers" do
      calculator = Calculator.new
      expect(calculator.divide(10,2)).to eql(5)
    end
  end
end
