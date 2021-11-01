require 'pry'

def func(file)
  f = File.open(file, 'r')
  highest_seat_id = 0
  f.each_line do |line|
    row = binary_finder(0, 127, line[0..6])
    column = binary_finder(0, 7, line[7..9])
    seat_id = row * 8 + column
    highest_seat_id = seat_id if highest_seat_id < seat_id
  end
  return highest_seat_id

end

def binary_finder(lower, upper, data)
  data.split("").each do |c|
    guess = (upper + lower)/2.0
    if %w(L F).include?(c) # lower half
      upper = guess.floor
    elsif %w(B R).include?(c)  # upper half
      lower = guess.ceil
    end
  end
  return %w(L F).include?(data[-1]) ? lower : upper
end

puts "enter input file"
input = gets.strip

puts func(input)
