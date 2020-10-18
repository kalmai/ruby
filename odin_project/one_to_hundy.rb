#Write a program that takes a number from the user between 0 and 100 and reports back whether the number is between 0 and 50, 51 and 100, or above 100.
puts "enter a number"
num = gets.chop.to_i
def zero_to_hundy(num)
  if num < 0
    puts "negative numbers are not allowed"
  elsif num >= 0 && num <= 50
    puts "#{num} between 0 and 50"
  elsif num >= 51 && num <= 100
    puts "#{num} between 51 and 100"
  else
    puts "#{num} above 100"
  end
end
zero_to_hundy(num)
