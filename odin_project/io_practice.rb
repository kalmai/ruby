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
#  file2 = File.open(file_name, 'r') do |f|
#    f.gets
#    puts f.eof?
#  end

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

def file_splitter
  # Develop an application that takes a significantly large input file and splits it into smaller file chunks. These types of files use to be used quite common back in the earlier days of computing when disks such as floppies were much smaller and couldn’t hold a larger program on their own.
  #
  # In order to determine how many files need to be produced, ask the user for the maximum amount of lines that should appear in each output file.
  #
  # Where is the input file (please include the path to the file)? [path-to-file]/input.txt
  # How many lines of text (max) should there be in the split files? 3
  # The input file has 50 lines of text.
  #
  # Each file that is created should have a sequential number assigned to it.
  #
  # For a 50 line input file "input.txt" this will produce 17 output files.
  #
  # **GENERATING OUTPUT**
  #
  # Generating input-1.txt
  # Generating input-2.txt
  # Generating input-3.txt
  puts "enter the file you would like to split 'FizzBuzz.txt'"
  original_file = gets.strip

  while !File.file?(original_file)
    puts "please enter a valid file or exit"
    original_file = gets.strip
    exit if original_file.eql?("exit")
  end

  puts "enter how many lines you would like to split #{original_file} by?"
  lines_of_text_per_file = gets.to_i

  file_lines = `wc -l #{original_file}`.split(" ")[0].to_i
  number_of_files_to_be_created = ( file_lines / lines_of_text_per_file.to_f ).ceil

  # explore using dir class in the future or now
  puts "#{original_file} contains #{file_lines} and will produce #{number_of_files_to_be_created} output files"
  !File.directory?("delete_this") ? `mkdir delete_this` : (`rm -rf delete_this`; `mkdir delete_this`)
  file_array = []

  (number_of_files_to_be_created).times do |i|
    file_array.push(File.new("delete_this/input-#{i + 1}", "w"))
    puts "generating input-#{i + 1}"
  end

  opened_file = File.open(original_file, "r")

  break_points = []
  num = lines_of_text_per_file
  (number_of_files_to_be_created - 1).times do
    break_points.push(num)
    num += lines_of_text_per_file
  end
  
  i = 0
  while i < file_lines
    opened_file.each_line do |line|
      if break_points.include?(i)
        file_to_be_closed = file_array.shift
        file_to_be_closed.close
      end
      file_array[0].puts line
      i += 1
    end
  end

end 

def fizz_buzz
  # Create a program to write out the result of FizzBuzz (1 to 300) to a file called FizzBuzz.txt. The file should be written out to the same directory as this README file.
  #
  # If the number is divisible by 3 or contains a 3, print “Fizz”
  # If the number is divisible by 5 or contains a 5, print “Buzz”
  # If the number is divisible by 3 and 5, print “FizzBuzz”
  # Otherwise print the number.
  puts "enter to what digit you want to print fizz-buzz"
  input = gets.to_i
  while input > 300 || input < 1
    puts "please enter an integer between 1 and 300"
    input = gets.to_i
  end
  new_file = File.new("FizzBuzz.txt", "w")
  for i in 1..input
    if i % 3 == 0 && i % 5 == 0
      new_file.puts "FizzBuzz"
    elsif i % 3 == 0 || i.to_s.split("").include?("3")
      new_file.puts "Fizz"
    elsif i % 5 == 0 || i.to_s.split("").include?("5")
      new_file.puts "Buzz"
    else 
      new_file.puts i
    end
  end
end

def method_selector
  puts "0. word_finder"
  puts "1. quiz_master"
  puts "2. fizz_buzz"
  puts "3. file_splitter"
  puts "999. exit"
  input = gets.to_i
  case input
  when 0 
    word_finder()
  when 1 
    quiz_master()
  when 2
    fizz_buzz
  when 3
    file_splitter
  when 999
    exit
  end
end

method_selector
