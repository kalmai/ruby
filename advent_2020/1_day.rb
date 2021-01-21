# https://adventofcode.com/2020/day/1

# --- Day 1: Report Repair ---
# After saving Christmas five years in a row, you've decided to take a vacation at a nice resort on a tropical island. Surely, Christmas will go on without you.
#
# The tropical island has its own currency and is entirely cash-only. The gold coins used there have a little picture of a starfish; the locals just call them stars. None of the currency exchanges seem to have heard of them, but somehow, you'll need to find fifty of these coins by the time you arrive so you can pay the deposit on your room.
#
# To save your vacation, you need to get all fifty stars by December 25th.
#
# Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!
#
# Before you leave, the Elves in accounting just need you to fix your expense report (your puzzle input); apparently, something isn't quite adding up.
#
# Specifically, they need you to find the two entries that sum to 2020 and then multiply those two numbers together.
#
# For example, suppose your expense report contained the following:
#
# 1721
# 979
# 366
# 299
# 675
# 1456
# In this list, the two entries that sum to 2020 are 1721 and 299. Multiplying them together produces 1721 * 299 = 514579, so the correct answer is 514579.
#
# Of course, your expense report is much larger. Find the two entries that sum to 2020; what do you get if you multiply them together?
#
# To play, please identify yourself via one of these services:

require 'pry'

def sum_2020_and_multiply
  puts "enter the the puzzle input"
  file_input = gets.strip
  
  while !File.file?(file_input)
    puts "please enter a valid puzzle input"
    file_input = gets.strip
  end

  puts "\nprocessing ..."

  file_reader = File.open(file_input, "r")

  num_arr = [nil, nil]
  i = 0
  changed = false
  
  file_length = `wc -l #{file_input}`.split(" ")[0].to_i

  while i < file_length - 1
    while changed == false
      file_reader.each_line do |line|
        i += 1
        if num_arr[0].nil? || (num_arr[0].keys[0] + 1) == i
          num_arr[0] = {i => line.to_i}
          changed = true
          break
        end
      end
      i = 0
    end

    while !file_reader.eof?
      file_reader.each_line do |line|
        num_arr[1] = line.to_i
        sum = num_arr[0].values[0] + num_arr[1]
        if sum == 2020
          puts "\n#{num_arr[0].values[0] * num_arr[1]} is the product of #{num_arr[0].values[0]} and #{num_arr[1]}"
          file_reader.close 
          exit
        end
      end
      changed = false
    end
    file_reader.rewind
  end
end

def sum_2020_and_multiply_three_values
  puts "enter the the puzzle input"
  file_input = gets.strip
  
  while !File.file?(file_input)
    puts "please enter a valid puzzle input"
    file_input = gets.strip
  end

  puts "\nprocessing ..."

  file_reader = File.open(file_input, "r")

  file_length = `wc -l #{file_input}`.split(" ")[0].to_i

    # using a binary search to do this, start from two ends of a list and look at indexes from left to right (this will likely be faster than the double loop)
    # try using a hash for all values in the arrays, use a normal hash and create a big ass hash and #select from it.
  # focus on the math, array of 4 things, know current value, if any other thing or anything i will look at, store key of x then 

  # think about the sum instead of the numbers 
  
  num_hsh = {}

  file_reader.each_line.with_index do |line, idx|
    num_hsh[idx] = line.to_i
  end

  file_reader.rewind
  first = []
  second = nil
  third = nil
  sum_of_first_and_second = 0

  for i in 1..file_length
    binding.pry

    first = num_hsh.first.dup
  end

#    num_hsh.each do |k, v|
#      i += 1
#      binding.pry
#      first = num_hsh.first.dup
#      if first[0] == i
#        next
#      end
#      if k == i
#        binding.pry
#        num_hsh.delete(first[0])
#        second = v
#        sum_of_first_and_second = first[1] + second
#        break
#      end
#    end



#    while !changed
#      num_hsh.each do |k, v|
#        binding.pry
#        i += 1
#        if k == i
#          second = [k, v]
#          changed = true
#          break
#        end
#      end
#    end
#    changed = false
#
#    if sum_of_first_and_second < 2020
#      remainder = 2020 - sum_of_first_and_second
#      num_hsh.each do |k, v|
#        third = [k, v]
#        puts "f #{first}, s #{second}, t #{third} multiplied = "
#      end
#    end

end

#sum_2020_and_multiply
sum_2020_and_multiply_three_values
