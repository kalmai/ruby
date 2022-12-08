def solution(filename = 'input.txt')
  signal = File.read(filename).strip
  packet_start = []
  signal.split('').each.with_index(1) do |char, i|
    packet_start.shift if packet_start.size == 4
    packet_start.push(char)
    return i if packet_start.tally.values.size == 4
  end
end

puts solution # ('sample.txt')
