require 'pry'
require './colorize'

class Hangman
  include Color

  @@guesses = []
  @@word = ""
  @@wrong_guess_count = 0

  def initialize; end

  def colorize_guesses
    colorized_chars = @@guesses.each.with_object([]) do |c, arr|
      color = @@word.include?(c) ? 'green' : 'red'
      arr.push(Color::colorize(color, c))
    end

    colorized_chars.join(', ')
  end


  def pick_a_word(file)
    file_length = `wc -l #{file}`.split(' ')[0].to_i
    word_number = rand(0..file_length)
    new_word = ""
    i = 0

    File.open(file, 'r') do |f|
      until f.eof? 
        word = f.gets.strip
        if i == word_number && word.length >= 5 && word.length <= 12
          new_word = word
        elsif i == word_number && (word.length < 5 || word.length > 12)
          word_number += 1
        end
        break if new_word.length > 0
        i += 1
      end
      @@word = new_word.downcase
      puts new_word
    end
  end

  def display_word
    system('clear')
    puts "you've guessed: #{colorize_guesses} and have #{6 - @@wrong_guess_count} #{@@wrong_guess_count == 5 ? 'guess' : 'guesses'} remaining" if @@guesses.size > 0
    @@word.split('').each do |c|
      print @@guesses.include?(c) ? c << " " : "_ "
    end
    puts ""
  end

  def get_input
    puts "enter a character to take a guess"
    input = gets.strip.downcase
    while @@guesses.include?(input) || input.length > 1
      puts "please enter a character you haven't guessed yet. (you've guessed: #{colorize_guesses})"
      input = gets.strip.downcase
    end

    @@guesses.push(input)
    @@wrong_guess_count += 1 if @@word.include?(input) == false
  end

  def game_over?
    if @@word.split('').all? { |c| @@guesses.include?(c) }
      puts Color::colorize('green', "you've guessed '#{@@word}' correctly, congratulations!")
      exit
    elsif @@wrong_guess_count == 6
      puts Color::colorize('red', "you ran out of guesses and the correct word was #{@@word}")
      exit
    end
    
  end

  def play
    pick_a_word('5desk.txt')
    system('clear')
    display_word
    until game_over?
      input = get_input
      display_word
    end
  end

end

new_game = Hangman.new
new_game.play
