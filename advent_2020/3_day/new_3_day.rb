require 'pry'

module TreeCalc
  def tree_calc(file, right, down)
    input_file = File.open(file, 'r')
    down_pos = 1
    right_pos = 1
    line_count = 1
    tree_count = 0

    input_file.each_line do |line|
      #binding.pry if line_count == 3 || line_count == 7
      x_pos = return_x_pos(right_pos)
      if line_count == down_pos
        tree_count += 1 if hits_a_tree?(x_pos, line)
        down_pos += down
        right_pos += right
      end
      line_count += 1
    end
    input_file.close
    puts tree_count
    return tree_count
  end

  def return_x_pos(idx)
    until idx < 32 do
      idx -= 31
    end
    return idx - 1
  end

  def hits_a_tree?(idx, str)
    if str.length > 0 && str.strip[idx].eql?("#")
      return true
    end
    false
  end

end

puts "enter input"
input = gets.strip

include TreeCalc

a = tree_calc(input, 1, 1)
b = tree_calc(input, 3, 1)
c = tree_calc(input, 5, 1)
d = tree_calc(input, 7, 1)
e = tree_calc(input, 1, 2)

puts a * b * c * d * e
