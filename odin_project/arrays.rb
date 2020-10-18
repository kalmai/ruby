#Below we have given you an array and a number. Write a program that checks to see if the number appears in the array.

def check_num_in_arry
  arr = [1, 3, 5, 7, 9, 11]
  puts arr.to_s
  puts "check whether number appears in array or not"
  input = gets.strip.to_i
  bool = arr.include?(input)
  puts "#{input} is included in the array" if bool == true
  puts "#{input} is not included in the array" if bool == false
end

#Use the each_with_index method to iterate through an array of your creation that prints each index and value of the array.

def each_with_index
  arr = [1, 3, 5, 7, 9, 11]
  puts arr.to_s
  arr.each_with_index { |val, idx| puts "#{idx} value is #{val}" }
end

#Write a program that iterates over an array and builds a new array that is the result of incrementing each value in the original array by a value of 2. You should have two arrays at the end of this program, The original array and the new array you've created. Print both arrays to the screen using the p method instead of puts.

def add_two_to_an_arr
  arr = [1,3,5,7,9,11]
  arr2 = arr.map{|x| x+2}
  p arr
  p arr2
end

def menu
  puts "select which method you would like to call"
  puts "1. check_num_in_arry"
  puts "2. each_with_index"
  puts "3. add_two_to_an_arr"
  puts "0. quit program"
  method_selection = gets.to_i

  case method_selection
    when 1 then
      check_num_in_arry
      menu 
    when 2 then 
      each_with_index
      menu
    when 3 then 
      add_two_to_an_arr
      menu
    when 0 then exit 
    else puts "select a valid input"
      menu
  end
end


menu
