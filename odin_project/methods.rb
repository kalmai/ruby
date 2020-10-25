# Write a program that prints a greeting message. This program should contain a method called greeting that takes a name as its parameter and returns a string.

def greetings(name="user")
  "hello #{name}, i have greeted you!"
end

puts greetings("zachary")
puts greetings + "(default value assigned)"

# Write a program that includes a method called multiply that takes two arguments and returns the product of the two numbers.

def multiply(num1, num2)
  num1 * num2
end

puts "the product of 3 and 4 is " + multiply(3,4).to_s

# 1) Edit the method definition in exercise #4 so that it does print words on the screen. 2) What does it return now?

def scream(words)
  words = words + "!!!!"
  puts words
end

scream("Yippeee")
