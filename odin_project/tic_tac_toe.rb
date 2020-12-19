# build a tic-tac-toe game on the command line where two human players can play against each other and the board is displayed in between turns.iq

#1. Think about how you would set up the different elements within the game… What should be a class? Instance variable? Method? A few minutes of thought can save you from wasting an hour of coding.
#2. Build your game, taking care to not share information between classes any more than you have to.
#3. Post your solution below, then check out the example solution provided.

require './colorize'

class Tile
  require 'pry'

  @@tile_name = %w(a b c d e f g h i)
  @@tile_value= [2,3,4,5,6,7,8,9,10]

  attr_accessor :name_of_tile, :value_of_tile, :picked

  def initialize()
    @name_of_tile= @@tile_name.first
    @value_of_tile= @@tile_value.first
    @@tile_name.shift
    @@tile_value.shift
  end

  def change_status(player)
    self.status = player
  end
end

class Game
  include Color
  attr_accessor :won, :player, :x_selections, :o_selections

  def initialize
    @won = false
    @player = 'X'
    @x_selections = {}
    @o_selections = {}
  end

  def change_player()
    self.player.eql?('O') ? self.player = 'X' : self.player = 'O'
  end

  def update_tile_name(tile, game_tiles)
    game_tiles.find { |t| t.name_of_tile = self.player if t.name_of_tile.eql?(tile) }
  end

  def update_selections(input, tiles)
    v = tiles.find { |t| t.name_of_tile.eql?(input) } 
    self.player.eql?('X') ? self.x_selections[input] = v.value_of_tile: self.o_selections[input] = v.value_of_tile 
  end

  def won?(tiles)
    if WIN_CONDITIONS.any? { |con| self.x_selections.select { | k, _ | con[0].include?(k) }.values.reduce(:*) == con[1] }
      display(tiles)
      puts Color::colorize("red","congrats player X, you've won!")
      exit
    elsif WIN_CONDITIONS.any? { |con| self.o_selections.select { | k, _ | con[0].include?(k) }.values.reduce(:*) == con[1] }
      display(tiles)
      puts Color::colorize("green","congrats player O, you've won!")
      exit
    elsif self.x_selections.size + self.o_selections.size == 9 && WIN_CONDITIONS.none? { |con| self.o_selections.select { | k, _ | con[0].include?(k) }.values.reduce(:*) == con[1] }
      display(tiles)
      puts "there is no winner, play again"
      exit
    end
  end

  def display(game_tiles)
    system("clear")
    puts "select a tile player: #{self.player}"
    puts "enter 'exit' to exit early"
    i = 0
    3.times do
      str = ""
      3.times do
        str << game_tiles[i].name_of_tile << " " 
        i += 1
      end
      puts str
      str = ""
    end
  end

  # 2 3 4  | 24
  # 5 6 7  | 210
  # 8 9 10 | 720
  #--------
  # 80, 162, 280
  # tl/br = 120
  # bl/tr = 
  # winning products
  # 6, 120, 504, 28, 80, 162, 45, 105

  # a b c
  # d e f
  # g h i

  # fails on 2 4 9 5

  WIN_CONDITIONS = [
    [%w(a b c), 24],
    [%w(d e f), 210],
    [%w(g h i), 720],
    [%w(a d g), 80],
    [%w(b e h), 162],
    [%w(c f i), 280],
    [%w(a e i), 120],
    [%w(g e c), 192]
  ]

  def self.valid_input?(input, arr)
    arr.delete(input) if arr.include?(input)
  end

  def self.play
    game_tiles = Array.new(9){ Tile.new() }
    game_instance = Game.new()

    system("clear")
    puts "enter anything to play or 'exit' to quit"
    player_input = gets.strip

    valids = %w(a b c d e f g h i exit)
    while(!player_input.eql?('exit'))
      game_instance.display(game_tiles)
      player_input = gets.strip
      if valid_input?(player_input, valids)
        game_instance.update_selections(player_input, game_tiles)
        game_instance.update_tile_name(player_input, game_tiles)
        game_instance.change_player
        game_instance.won?(game_tiles)
      else
        puts
        puts "enter a valid tile name"
        puts
      end
    end
  end
end

Game.play
