require 'pry'

def solution(filename = 'input.txt')
  crates, moves = File.read(filename).split("\n\n")
  stacks = crates
           .slice!(crates.split("\n").last)
           .split('')
           .select { |s| ('0'..'9').to_a.include?(s) }
           .map(&:to_i)
           .to_h { |v| [v, []] }
  i = 0
  crates.split("\n").each do |crate|
    a = crate.chars.each_slice(4).map(&:join)
    binding.pry
  end
end

puts solution('sample.txt')
