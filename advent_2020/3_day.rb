# With the toboggan login problems resolved, you set off toward the airport. While travel by toboggan might be easy, it's certainly not safe: there's very minimal steering and the area is covered in trees. You'll need to see which angles will take you near the fewest trees.
#
# Due to the local geology, trees in this area only grow on exact integer coordinates in a grid. You make a map (your puzzle input) of the open squares (.) and trees (#) you can see. For example:
#
# ..##.........##.........##.........##.........##.........##.......  --->
# #..O#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..
# .#....X..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.
# ..#.#...#O#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#
# .#...##..#..X...##..#..#...##..#..#...##..#..#...##..#..#...##..#.
# ..#.##.......#.X#.......#.##.......#.##.......#.##.......#.##.....  --->
# .#.#.#....#.#.#.#.O..#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#
# .#........#.#........X.#........#.#........#.#........#.#........#
# #.##...#...#.##...#...#.X#...#...#.##...#...#.##...#...#.##...#...
# #...##....##...##....##...#X....##...##....##...##....##...##....#
# .#..#...#.#.#..#...#.#.#..#...X.#.#..#...#.#.#..#...#.#.#..#...#.#  --->
#
# You start on the open square (.) in the top-left corner and need to reach the bottom (below the bottom-most row on your map).
#
# The toboggan can only follow a few specific slopes (you opted for a cheaper model that prefers rational numbers); start by counting all the trees you would encounter for the slope right 3, down 1:
#
# From your starting position at the top-left, check the position that is right 3 and down 1. Then, check the position that is right 3 and down 1 from there, and so on until you go past the bottom of the map.
#
# The locations you'd check in the above example are marked here with O where there was an open square and X where there was a tree:
#
# You start on the open square (.) in the top-left corner and need to reach the bottom (below the bottom-most row on your map).
#
# The toboggan can only follow a few specific slopes (you opted for a cheaper model that prefers rational numbers); start by counting all the trees you would encounter for the slope right 3, down 1:
#
# From your starting position at the top-left, check the position that is right 3 and down 1. Then, check the position that is right 3 and down 1 from there, and so on until you go past the bottom of the map.
#
# The locations you'd check in the above example are marked here with O where there was an open square and X where there was a tree:

require 'pry'

def tree_nav(horizontal_amount, vertical_amount, input = nil)
  if input.nil?
    puts "enter the input file"
    input = gets.strip
  end

  while !File.file?(input)
    puts "#{input} is not a valid file, please enter a valid file"
    input = gets.strip
  end

  file_reader = File.open(input)

  position = 0 
  down_count = vertical_amount
  tree_count = 0

  file_reader.each_line do |line|
    forest = line.strip
#    binding.pry if vertical_amount == 2

    if down_count == vertical_amount
      temp_position = position > forest.length ? position % forest.length : position
      value_at_position = forest[temp_position]

      tree_count += 1 if value_at_position.eql?('#')
      position += horizontal_amount
      down_count = 1 if vertical_amount > 1
      next
    end
    down_count += 1
  end

  file_reader.close

  puts "you encountered #{tree_count} trees descending the slope that was #{`wc -l #{input}`.split(" ")[0].to_i} long by moving horizontally #{horizontal_amount} and down by #{vertical_amount}"

  return tree_count
end

a = tree_nav(1,1,'input-3.txt')
b = tree_nav(3,1,'input-3.txt')
c = tree_nav(5,1,'input-3.txt')
d = tree_nav(7,1,'input-3.txt')
e = tree_nav(1,2,'input-3.txt')

puts "when you multipy all slopes together you get #{a * b * c * d * e}"
