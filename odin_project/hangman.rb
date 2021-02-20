require 'pry'
require './colorize'
require 'json'

class Hangman
  include Color

  @@guesses = []
  @@word = ""
  @@wrong_guess_count = 0
  @@game_id = 0

  def initialize; end

  def get_new_game_id
    file = File.read('saved_hangman_game.json')
    data = JSON.parse(file)
    new_id = data.keys.last.to_i + 1
    @@game_id = new_id
  end

  def save_game_to_json
    file = File.read('saved_hangman_game.json')
    data = JSON.parse(file)
    id = get_new_game_id
    if data[@@game_id.to_s].nil?
      data[@@game_id] = {
        "word" => @@word,
        "guesses" => @@guesses,
        "wrong_guess_count" => @@wrong_guess_count
      }
    else
      data[@@game_id.to_s]['guesses'] = @@guesses
      data[@@game_id.to_s]['wrong_guess_count'] = @@wrong_guess_count
    end

    File.write('saved_hangman_game.json', JSON.dump(data))
  end

  def read_saved_game
    system('clear')
    file = File.read('saved_hangman_game.json')
    data = JSON.parse(file)
    puts "select one of the following sessions:"
    num_hsh = {}
    data.keys.each.with_index do |k, i|
      str = ''
      hidden_word = data[k]['word'].split('').each.with_object("") do |c, s|
        char = data[k]['guesses'].include?(c) ? c << " " : "_ "
        s << char
      end

      str << "#{i + 1}: #{hidden_word} [" << data[k]['guesses'].join(', ') << '] ' << data[k]['wrong_guess_count'].to_s
      num_hsh[i + 1] = k
      puts str 
    end
    input = gets.to_i

    until num_hsh.keys.include?(input)
      puts "enter a valid session: #{num_hsh.keys.join(', ')}"
      input = gets.strip
    end

    choice = data[num_hsh[input]]
    binding.pry
    @@guesses = choice['guesses']
    @@word = choice['word']
    @@game_id = num_hsh[input]
    @@wrong_guess_count = choice['wrong_guess_count']
    binding.pry
  end

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
    system('clear')
    display_word
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

  def save_game?
    puts "enter 'y' to save or 'n' to continue"
    input = gets.downcase.strip

    until input.eql?('y') || input.eql?('n')
      puts "enter 'y' to save or 'n' to continue"
      input = gets.downcase.strip
    end

    input.eql?('y') ? true : false
  end

  def load_saved_game?
    display_word
    system('clear')
    puts "enter 'y' to load your save or 'n' to continue"
    input = gets.downcase.strip

    until input.eql?('y') || input.eql?('n')
      display_word
      system('clear') 
      puts "enter 'y' to load your save or 'n' to continue"
      input = gets.downcase.strip
    end

    read_saved_game if input.eql?('y')
  end

  def play
    pick_a_word('5desk.txt')
    system('clear')
    load_saved_game?
    display_word
    until game_over?
      get_input
      display_word
      save_game_to_json if save_game?
    end
  end

end

new_game = Hangman.new
new_game.play
