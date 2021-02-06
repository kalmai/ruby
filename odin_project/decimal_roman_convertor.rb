# convert decimal to roman numerals

require 'pry'

def convertor
  puts "enter an integer to convert"
  input = gets.strip

  is_i = input == input.to_i.to_s
  
  until is_i && input.to_i <= 3000
    puts "enter a valid integer or a value less than 3000"
    input = gets.strip
    is_i = input == input.to_i.to_s
  end

  digit_= {
    1 => %w( X V I ),
    2 => %w( C L X ),
    3 => %w( M D C ),
    4 => %w( * * M)
  }

  roman_value = ""
  remainder = input.dup

  digits = {}
  
  i = remainder.length
  digit_place = 1 

  while i > 0
    current_digit = remainder[i - 1].to_i
    high = digit_[digit_place][0]
    middle = digit_[digit_place][1]
    low = digit_[digit_place][2]

    if current_digit == 9
      roman_value << high << low 
      current_digit = 0
    end
    if current_digit >= 5
      current_digit -= 5
      (current_digit).times { roman_value << low }
      roman_value << middle
      current_digit = 0
    end
    if current_digit == 4
      roman_value << middle << low 
      current_digit = 0 
    end
    if current_digit <= 3
      (current_digit).times { roman_value << low }
      current_digit = 0
    end

    digit_place += 1
    i -= 1
  end

  puts "you entered #{input} which is #{roman_value.reverse} in roman numerals"

end

convertor
