require 'pry'

def solution(filename = 'input.txt')
  crates, moves = File.read(filename).split("\n\n")
  stacks = crates
           .slice!(crates.split("\n").last)
           .split('')
           .select { |s| ('0'..'9').to_a.include?(s) }
           .map(&:to_i)
           .to_h { |v| [v, []] }
  crates.split("\n").each do |crate|
    crate.chars.each_slice(4).map(&:join).each.with_index(1) do |str, i|
      box = str.scan(/\w+/)
      stacks[i].unshift(box) unless box.empty?
    end
  end

  moves = moves.split("\n").map do |str|
    move = str.split(' ').select { |s| s.to_i > 0 }.map(&:to_i)
    Move.new(*move)
  end

  moves.each do |m|
    start_stack = stacks[m.start_pos]
    moving_boxes = start_stack.slice!((start_stack.length - m.boxes)..)
    moving_boxes.reverse.each { |b| stacks[m.end_pos].push(b) }
  end
  stacks.values.map(&:last).join
end

Move = Struct.new(:boxes, :start_pos, :end_pos)

puts solution # ('sample.txt')
