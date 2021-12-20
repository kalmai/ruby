require 'pry'

def position_finder(file)
  f = File.new(file, 'r')
  aim = 0 
  horizontal = 0
  vertial = 0

  f.each_line do |line|
    line_arr = line.strip.split(' ')
    direction = line_arr[0]
    moves = line_arr[1].to_i

    case direction
    when 'down'
      aim += moves
    when 'up'
      aim -= moves
    when 'forward' then horizontal += moves; vertial += (aim * moves)
    end
  end

  vertial * horizontal
end

puts position_finder('input.txt')
