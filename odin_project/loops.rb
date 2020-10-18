# Write a while loop that takes input from the user, performs an action, and only stops when the user types "STOP". Each loop can get info from the user.

loop do 
  puts "enter something and STOP to end"
  x = gets.strip
  break if x == "STOP"
end

# provided solution

#x = ""
#while x != "STOP" do
#  puts "Hi, How are you feeling?"
#  ans = gets.chomp
#  puts "Want me to ask you again?"
#  x = gets.chomp
#end

puts "enter a positive integer to countdown"
num = gets.strip.to_i
def countdown(num)
  puts num
  num-=1
  if(num > 0)
    countdown(num)
  end
end
countdown(num)
