puts "what is ur current age m8e?"
current_age = gets.chop.to_i
i = 0
while i < 40 do
  i += 10
  puts "in #{i} years you will be: #{current_age + i}"
end

