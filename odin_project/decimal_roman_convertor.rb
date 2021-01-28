# convert decimal to roman numerals

require 'pry'

def convertor(input)
  literals = {
    1 => "I",
    5 => "V",
    10 => "X",
    50 => "L",
    100 => "C",
    500 => "D",
    1000 => "M"
  }

  roman_value = ""
  remainder = input.dup
  thousands = remainder.to_s[0] << "000" if remainder.to_s.length == 4

  digits = {
    "4" => [0,0],
    "3" => [0,0],
    "2" => [0,0],
    "1" => [0,0]
  }

  i = remainder.to_s.length
  
  until i < 0 do 
    i -= 1
    binding.pry
  end




  puts "you entered #{input} which is #{roman_value} in roman numerals"

end

puts "enter an integer to convert"
input = gets.to_i

convertor(input)
