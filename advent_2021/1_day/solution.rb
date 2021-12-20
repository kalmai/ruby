require 'pry'

def depth_increase_counter(file)
  previous_sum = 0
  increase_count = 0
  queue = []
  f = File.new(file, 'r')

  f.each_line do |line|
    queue.push(line.to_i)
    queue.shift if queue.size > 3
    if queue.size == 3
      increase_count += 1 if queue.sum > previous_sum
      previous_sum = queue.sum
    end
  end
  increase_count
end

puts depth_increase_counter('input.txt')
# puts depth_increase_counter('sample.txt')
