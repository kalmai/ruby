require 'pry'

def solution(filename)
  priority = (('a'..'z').to_a << ('A'..'Z').to_a).flatten.unshift('@@@')
  duplicates = []
  data = File.read(filename).split("\n")
  group = []
  data.each do |contents|
    group << contents.split('') if group.size < 3
    if group.size == 3
      group.first.each do |char|
        if group[1].include?(char) && group.last.include?(char)
          duplicates.push(char)
          break
        end
      end
      group = []
    end
  end
  total = 0
  duplicates.each { |c| total += priority.index(c) }
  total
end

# puts solution('sample.txt')
puts solution('input.txt')
