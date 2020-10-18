# Write a method that takes a string as argument. The method should return a new, all-caps version of the string, only if the string is longer than 10 characters. Example: change "hello world" to "HELLO WORLD". (Hint: Ruby's String class has a few methods that would be helpful. Check the Ruby Docs!)

puts "enter a string"
str = gets.chop

if str.length > 10 
  puts str.upcase
else
  puts str
end
