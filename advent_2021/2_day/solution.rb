require 'pry'

def position_finder(file)
  f = File.new(file, 'r')
  vertical = 0 
  horizontal = 0

  f.each_line do |line|
    line_arr = line.strip.split(' ')
    direction = line_arr[0]
    moves = line_arr[1].to_i

    case direction
    when 'down'
      vertical += moves
    when 'up'
      vertical -= moves
    when 'forward'
      horizontal += moves
    end
  end

  vertical * horizontal
end

puts position_finder('input.txt')
