# check whether or not an attendees of |x| age is included in the hash

def attendee_is_x_age?
  attendees = {
    brian: 21,
    andy: 19,
    tony: 50,
    teresa: 45,
    ninomiya: 31
  }

  puts "enter a number to search"
  input = gets.to_i

  attendees.values.include?(input)
end

puts attendee_is_x_age?

# now check whether or not the attendees are above the age of 21 with the any? predicate enumerable method. if there is anyone below the age of 21 return true.

def below_21?
  attendees = {
    brian: 21,
    andy: 19,
    tony: 50,
    teresa: 45,
    ninomiya: 31
  }

  attendees.any?{ |_, age| age > 21 }
end

puts "#{below_21?} below 21"

# check if the whole class has passed the test by calculating the average score for each student. passing is above 70%

def class_average_above_70?
  class_b = {
    brian: [70,60,100,100],
    andy: [50,100,90,80],
    tony: [100,100,100,70],
    teresa: [90,90,90,90],
    ninomiya: [0,80,0,80]
  }

  class_b.all?{ |_, scores| (scores.reduce{ |sum, num| sum + num } / scores.length) > 70 }
end  

puts class_average_above_70?

# write a method that returns true when none of the keys contain the user input. otherwise return false

def validate_keys
  class_b = {
    brian: [70,60,100,100],
    andy: [50,100,90,80],
    ton99y: [100,100,100,70],
    teresa: [90,90,90,90],
    ninomiya: [0,80,0,80]
  }

  puts "enter a character you want to check whether or not the hask keys contain"
  input = gets.chomp

  class_b.none? { |name, _| name.to_s.include?(input) }
end

puts validate_keys

