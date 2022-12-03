def solution(filename)
  priority = (('a'..'z').to_a << ('A'..'Z').to_a).flatten.unshift('@@@')
  duplicates = []
  data = File.read(filename).split("\n")
  data.each do |contents|
    small_compartment = contents[0...(contents.length / 2)].split('')
    large_compartment = contents[(contents.length / 2)..].split('')
    small_compartment.each do |item|
      if large_compartment.include?(item)
        duplicates.push(item)
        break
      end
    end
  end
  total = 0
  duplicates.each { |c| total += priority.index(c) }
  total
end

# puts solution('sample.txt')
puts solution('input.txt')
