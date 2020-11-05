# Write a program that checks if the sequence of characters "lab" exists in the following strings. If it does exist, print out the word.

def str_finder
  words = ["laboratory", "experiment", "Pans Labyrinth", "elaborate", "polar bear"]

  words.each do |word_itt|
    word = word_itt
    for i in 0...word.length - 2
      puts word if word.downcase[i...i+3] == "lab"
    end
  end
end

puts "str_finder"

str_finder

def str_includer
  words = ["laboratory", "experiment", "Pans Labyrinth", "elaborate", "polar bear"]

  words.each { |word| puts word if word.downcase.include?("lab") }
end

puts
puts "str_includer"

str_includer


# Modify the code in exercise 2 to make the block execute properly.

# CODE from exercise 2
#
#def execute(&block)
#  block
#end

#execute { puts "Hello from inside the execute method!" }

def execute(&block)
  block.call
end

execute { puts "Hello from inside the execute method!" }
