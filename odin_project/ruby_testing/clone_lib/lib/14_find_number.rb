# frozen_string_literal: true

# class for computer to find random number
class FindNumber
  attr_reader :min, :max, :answer, :guess

  def initialize(min, max, answer = RandomNumber.new(min, max), guess = nil)
    @min = min
    @max = max
    # The RandomNumber class will have an instance variable '@value'
    @answer = answer.value
    @guess = guess
  end

  def make_guess
    (@min + @max)/2.to_i
  end

  def game_over?
    @answer == @guess
  end

  def update_range
    @min = @guess + 1 if @guess < @answer
    @max = @max - 1 if @guess > @answer
  end

end
