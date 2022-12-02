require 'pry'
# https://adventofcode.com/2022/day/1

def solution(file_name)
  data = File.read(file_name)
  most_calories = [0, -1, -2]
  elf_calories = data.split("\n\n")
  elf_calories.each do |str|
    total_calories = str.split("\n").map(&:to_i).sum
    least_most_calories = most_calories.min
    most_calories[most_calories.index(least_most_calories)] = total_calories if total_calories > most_calories.min
  end
  most_calories.sum
end

# puts solution('sample.txt')
puts solution('input.txt')
