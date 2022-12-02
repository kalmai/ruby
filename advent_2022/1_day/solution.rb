require 'pry'
# https://adventofcode.com/2022/day/1

def solution(file_name)
  data = File.read(file_name)
  most_calories = -9999
  elf_calories = data.split("\n\n")
  elf_calories.each do |str|
    total_calories = str.split("\n").map(&:to_i).sum
    most_calories = total_calories if total_calories > most_calories
  end
  most_calories
end

# puts solution('sample.txt')
puts solution('input.txt')
