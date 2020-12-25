# Write a program that asks the user for a search string and a filesystem path for a text file. When the problem is run, it searches the file for occurrences of the search string and each time it finds a line that matches, it displays the line number and contents of the line it was found in on the console.
# EXAMPLE BELOW
# What is the file that should be searched?
# [path-to-the-file]
# What is the search word you are looking for?
# dog
# 604) conversation. "Are you--are you fond--of--of dogs?" The Mouse did not
# 605) answer, so Alice went on eagerly: "There is such a nice little dog near
# 617) won't talk about cats or dogs either, if you don't like them!"
# 622) history, and you'll understand why it is I hate cats and dogs."
# 1728) "To begin with," said the Cat, "a dog's not mad. You grant that?"
# 1732) "Well, then," the Cat went on, "you see a dog growls when it's angry,

#fd = IO.sysopen('alices_adventures_in_wonderland.txt', 'r')
#
#my_first_read_line_in_ruby = IO.new(fd)
#
#puts my_first_read_line_in_ruby.pos
#puts my_first_read_line_in_ruby.gets
#
#puts my_first_read_line_in_ruby.eof?
#
require 'pry'

def word_finder
#  fd = IO.sysopen('alices_adventures_in_wonderland.txt', 'r')
#  reader = IO.new(fd)
#  while reader.eof? == false
#    if reader.gets.downcase.include?(input.downcase)
#      puts reader.pos.to_s 
#      puts reader.gets
#    end
#  end
  puts "input the file you would like to search for words (use alice.txt)"
  file_name = gets.strip

  puts "input the word you would like to search for"
  input = gets.strip

# Modify the WordSearch program to ask the user if the search should be case insensitive.
  puts "will this be case sensitive? (y/n)"
  downcase = gets.strip.downcase

  i = 0
  file = File.new(file_name, 'r')

  file.each_line do |line|
    i += 1
    case downcase
    when 'y' 
      if line.include?(input)
        puts "#{i}) " << line
      end 
    when 'n'
      if line.downcase.include?(input.downcase)
        puts "#{i}) " << line
      end
    end
  end

end

word_finder

# Create a quiz maker program which asks the user a question. They should be presented with the possible multiple choice answers and allowed to specify the correct answer.
#
#The program should read the questions from an input file during startup. The questions and answers in the file will be pipe delimited ("|") and correct answers will be marked with an asterisk ("*") in the file.

def quiz_master
  file = File.new('questions.txt')

  # Go through all of the available quiz questions and ask the user each one sequentially. Record how many answers they got correct and print out the total at the end.

  total_questions = 0
  player_score = 0
  
  file.each_line do |line|
    total_questions += 1
    line_arr = line.split("|")

    puts line_arr.shift

    correct_ans = 999
    line_arr.each_with_index { |q, i| correct_ans = i if q.include?("*") }
    line_arr[correct_ans] = line_arr[correct_ans].gsub("*", "")

    line_arr.each_with_index { |ans, idx| puts (idx += 1).to_s << ") " << ans }
    puts "enter the number to see if you were correct"
    input = gets.to_i

    puts (input - 1) == correct_ans ? "#{line_arr[input - 1]} was the correct answer!" : "#{line_arr[input - 1]} was incorrect"
    player_score += 1 if (input - 1) == correct_ans

    
  end
  puts "your final score was #{player_score} out of #{total_questions}"
end

quiz_master
