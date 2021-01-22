# --- Day 2: Password Philosophy ---
# Your flight departs in a few days from the coastal airport; the easiest way down to the coast from here is via toboggan.
#
# The shopkeeper at the North Pole Toboggan Rental Shop is having a bad day. "Something's wrong with our computers; we can't log in!" You ask if you can take a look.
#
# Their password database seems to be a little corrupted: some of the passwords wouldn't have been allowed by the Official Toboggan Corporate Policy that was in effect when they were chosen.
#
# To try to debug the problem, they have created a list (your puzzle input) of passwords (according to the corrupted database) and the corporate policy when that password was set.
#
# For example, suppose you have the following list:
#
# 1-3 a: abcde
# 1-3 b: cdefg
# 2-9 c: ccccccccc
# Each line gives the password policy and then the password. The password policy indicates the lowest and highest number of times a given letter must appear for the password to be valid. For example, 1-3 a means that the password must contain a at least 1 time and at most 3 times.
#
# In the above example, 2 passwords are valid. The middle password, cdefg, is not; it contains no instances of b, but needs at least 1. The first and third passwords are valid: they contain one a or nine c, both within the limits of their respective policies.
#
# How many passwords are valid according to their policies?

require 'pry'

def password_verifier
  puts "enter a file to verify the passwords"
  input = gets.strip

  while !File.file?(input)
    puts "enter a valid file"
    input = gets.strip
  end

  file_reader = File.open(input)

  valid_passwords = 0

  puts "\nprocessing..."

  file_reader.each_line do |line|
    line_arr = line.split(" ")

    low_high_arr = line_arr[0].split("-")
    low = low_high_arr[0].to_i
    high = low_high_arr[1].to_i

    letter = line_arr[1][0].downcase

    char_count = 0
    line_arr[2].each_char { |c| char_count += 1 if c.eql?(letter) }

    valid_passwords += 1 if char_count >= low && char_count <= high
  end
  
  puts "\nthe number of valid passwords is #{valid_passwords}"
  file_reader.close

end

password_verifier
