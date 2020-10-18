puts "enter your first name"
first_name = gets.strip
puts "enter your last name"
last_name = gets.strip
full_name = first_name << " " << last_name
puts "your full name is #{full_name}\n\n"
i=0
while i < 10 do
  puts "#{full_name} with while loop"
  i+=1
  if i == 10 
    puts "\n"
  end
end

10.times do
  puts "#{full_name} with .times method"
end
puts""

i=0
for i in 0...10
  puts "#{full_name} with for loop"
  if i == 9
    puts ""
  end
end

i=0
until i > 9 do
  puts "#{full_name} with until loop"
  i+=1
  if i == 10
    puts ""
  end
end

10.times do |num|
  puts "#{full_name} with .times loop and arg"
  if num == 9
    puts ""
  end
end

0.upto(9) {|num|
  puts "#{first_name} with upto loop"
  if num == 9 
    puts ""
  end
}

9.downto(0) {|num|
  puts "#{first_name} with downto loop"
  if num == 0 
    puts ""
  end
}
