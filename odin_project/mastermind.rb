# Build a Mastermind game from the command line where you have 12 turns to guess the secret code, starting with you guessing the computer’s random code.

require './colorize'
require 'pry'

class Row
  include Color
  @@code_to_be_guessed = []
  @@codes = []
  @@valids = {
    "r" => "red",
    "g" => "green",
    "b" => "blue",
    "m" => "magenta"
  }
 
  def initialize; end

  # red, green, yellow, blue, magenta, cyan, white
  # colorize(String color, String str) implicity returns the string that has been colored
  # Color::colorize("red","asdf")
  # when i wanna add color just do above with color 1st param and str 2nd param

  def display
    puts "colors  '-' = correct color '+' = correct color and position"
    @@codes.each_with_index { |c, i| puts c.each_with_object(String.new()) { |color, str| str << Color::colorize(color, " O") if @@valids.values.include?(color) } << c[4] if i != 0 } 
    # this needs 'if i != 0' on the end of line 24
  end

  def create_code
    arr = %w(red green blue magenta)
    4.times{ @@code_to_be_guessed.push(arr.sample) }
    @@code_to_be_guessed.push(" if you seee this, you're testing")
    @@codes.push(@@code_to_be_guessed)
  end

  def parse_input(str)
    arr = []
    str.split("").each_with_object(arr) do |c,arrays|
      arrays.push(@@valids[c]) if @@valids.keys.include?(c)
    end
    arr
  end

  def won?
    correct = @@code_to_be_guessed.dup
    guess = @@codes.last.dup
    correct.slice!(4)
    guess.slice!(4)
    if @@codes.size == 9
      puts "you did not guess the code within 8 guesses, the code was below. try again"
      puts @@code_to_be_guessed.each_with_object(String.new()) { |color, str| str << Color::colorize(color, " O") if @@valids.values.include?(color) }
    elsif correct == guess && @@codes.size < 9
      puts "you guessed the below code and won!"
      puts @@code_to_be_guessed.each_with_object(String.new()) { |color, str| str << Color::colorize(color, " O") if @@valids.values.include?(color) }
    else
      return false
    end
  end

  def get_input
    puts "enter #{Color::colorize("red","r")}, #{Color::colorize("green","g")}, #{Color::colorize("blue","b")}, or #{Color::colorize("magenta","m")} with no spaces to take a guess or 'exit' to quit"
    gets.strip
  end

  def player_clues(code)
    correct_code = @@code_to_be_guessed.tally.dup
    guessed_code = code.tally.dup
    message_arr = []
    cccp = 0
    hsh = {}

    @@code_to_be_guessed.each_with_index do |cc, i|
      if cc.eql?(code[i])
        correct_code[cc] -= 1
        guessed_code[cc] -= 1
        cccp += 1
      end
    end

    correct_code.each do |ck, cv|
      guessed_code.each do |gk, gv|
        if cv == gv && ck.eql?(gk)
          hsh[ck] = cv
        elsif ck.eql?(gk) && cv > 0 && gv > 0
          hsh [ck] = cv >= gv ? gv : cv
        end
      end
    end
    
    (cccp).times { message_arr.push(" +") }
    (hsh.values.sum).times { message_arr.push(" -") }
    message = message_arr.shuffle.each_with_object("") { |m, str| str << m }
    message.length > 0 ? @@codes.last.push(message) : @@codes.last.push(" no input was correct")
  end
  
  def sanitiza_input(input)
    arr = parse_input(input)
    arr.all? { |color| @@valids.values.include?(color) } && input.length == 4 
  end

  def play
    system("clear")
    game_over = false
    create_code
    puts "guess the secret four digit code within 8 turns to win!"
    while game_over == false
      input = get_input
      if input.eql?("exit")
        exit
      elsif sanitiza_input(input)
        @@codes.push(parse_input(input))
        player_clues(@@codes.last)
        system("clear")
        display
        game_over = won?
      else
        puts "enter a valid input"
      end
    end
  end

end

Row.new().play
