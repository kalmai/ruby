require 'pry'
require 'set'

def solution(filename)
  data = File.read(filename).split("\n")
  duplicated_tasks = 0
  data.each do |pair|
    elf1, elf2 = pair.split(',').map { |set| elf_sets(set) }
    duplicated_tasks += 1 if elf1.intersect?(elf2) || elf2.intersect?(elf1)
  end
  duplicated_tasks
end

def elf_sets(str)
  arr = str.split('-').map(&:to_i)
  (arr.min..arr.max).entries.to_set
end

puts solution('sample.txt')
# puts solution('input.txt')
