# In cryptography, a Caesar cipher, also known as Caesar’s cipher, the shift cipher, Caesar’s code or Caesar shift, is one of the simplest and most widely known encryption techniques. It is a type of substitution cipher in which each letter in the plaintext is replaced by a letter some fixed number of positions down the alphabet. For example, with a left shift of 3, D would be replaced by A, E would become B, and so on. The method is named after Julius Caesar, who used it in his private correspondence.

# Implement a caesar cipher that takes in a string and the shift factor and then outputs the modified string:
#
#   > caesar_cipher("What a string!", 5)
#  => "Bmfy f xywnsl!"

def caesar_cipher
  alphas = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)

  puts "enter a string you want to encode"
  str = gets.chomp
  puts "enter a positive or negative integer to shift \"#{str}\""
  shift = gets.to_i

  str_arr = str.split(" ")
  shifted_string = ""
  idx = 0

  str_arr.each do |word|
    shifted_word = ""
    word.split("") do |char|
      if alphas.index(char.downcase) + shift > alphas.size
        idx = (alphas.index(char.downcase) + shift) - 26
        shifted_word << alphas[idx]
      else
        shifted_word << alphas[alphas.index(char.downcase) + shift]
      end
    end
    shifted_string << " " << shifted_word
  end
  puts shifted_string.strip
end

caesar_cipher
