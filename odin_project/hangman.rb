require 'pry'
require './colorize'
require 'json'

class Hangman
  include Color

  @@guesses = []
  @@word = ""
  @@wrong_guess_count = 0
  @@game_id = 0
  @@in_memory_games = {}

  def initialize
    file = File.read('saved_hangman_game.json')
    @@in_memory_games = JSON.parse(file)
  end

  def get_new_game_id
    new_id = @@in_memory_games.keys.last.to_i + 1
    @@game_id = new_id
  end

  def delete_game_from_json(game_id)
    @@in_memory_games.delete(game_id)
    File.write('saved_hangman_game.json', JSON.dump(@@in_memory_games))
  end
    

  def save_game_to_json
    id = @@guesses.size > 0 ? @@game_id : get_new_game_id
    if @@in_memory_games[@@game_id.to_s].nil?
      @@in_memory_games[@@game_id] = {
        "word" => @@word,
        "guesses" => @@guesses,
        "wrong_guess_count" => @@wrong_guess_count
      }
    else
      @@in_memory_games[@@game_id.to_s]['guesses'] = @@guesses
      @@in_memory_games[@@game_id.to_s]['wrong_guess_count'] = @@wrong_guess_count
    end

    File.write('saved_hangman_game.json', JSON.dump(@@in_memory_games))
  end

  def read_saved_game
    if @@in_memory_games.keys.size > 0
      puts "select one of the following sessions:"
      num_hsh = {}
      @@in_memory_games.keys.each.with_index do |k, i|
        str = ''
        hidden_word = @@in_memory_games[k]['word'].split('').each.with_object("") do |c, s|
          char = @@in_memory_games[k]['guesses'].include?(c) ? c << " " : "_ "
          s << char
        end

        str << "#{i + 1}: word - #{hidden_word} guesses - [" << @@in_memory_games[k]['guesses'].join(', ') << '] - wrong guesses ' << @@in_memory_games[k]['wrong_guess_count'].to_s
        num_hsh[i + 1] = k
        puts str 
      end
      input = gets.to_i

      until num_hsh.keys.include?(input)
        puts "enter a valid session: #{num_hsh.keys.join(', ')}"
        input = gets.to_i
      end

      choice = @@in_memory_games[num_hsh[input]]
      @@guesses = choice['guesses']
      @@word = choice['word']
      @@game_id = num_hsh[input]
      @@wrong_guess_count = choice['wrong_guess_count']
    else
      puts "there are no saved games, start the following game and save it to load a game"
      sleep(2.5)
    end
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

  def process_guess(input)
    split_input = input.split(' ')
    if split_input[0].eql?('g') 
      guess = input.split(' ')[1]
      if @@word.split('').all? { |c| guess.include?(c) }
        puts Color::colorize('green', "you've guessed '#{@@word}' correctly, congratulations!")
        delete_game_from_json(@@game_id)
        exit
      else
        @@wrong_guess_count += 1
      end
    end
  end


  def get_input
    system('clear')
    display_word
    puts "enter a character to take a guess or 'g <your guess here>' to guess the word"
    input = gets.strip.downcase

    binding.pry
    if input.split(' ')[0].eql?('g')
      @@guesses.push(input.split(' ')[1])
      process_guess(input)
    else 
      while @@guesses.include?(input) || input.length > 1
        puts "please enter a character you haven't guessed yet. (you've guessed: #{colorize_guesses})"
        input = gets.strip.downcase
      end

      @@guesses.push(input)
      @@wrong_guess_count += 1 if @@word.include?(input) == false
    end

  end

  def game_over?
    if @@word.split('').all? { |c| @@guesses.include?(c) }
      puts Color::colorize('green', "you've guessed '#{@@word}' correctly, congratulations!")
      delete_game_from_json(@@game_id)
      true
    elsif @@wrong_guess_count == 6
      puts Color::colorize('red', "you ran out of guesses and the correct word was #{@@word}")
      delete_game_from_json(@@game_id)
      true
    else
      false
    end
  end

  def save_game?
    if !(@@wrong_guess_count == 6 || @@word.split('').all? { |c| @@guesses.include?(c) })
      puts "enter 'y' to save or 'n' to continue"
      input = gets.downcase.strip

      until input.eql?('y') || input.eql?('n')
        puts "enter 'y' to save or 'n' to continue"
        input = gets.downcase.strip
      end

      input.eql?('y') ? true : false
    end
  end

  def load_saved_game?
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
