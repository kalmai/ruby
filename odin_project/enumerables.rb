# for this lesson there were no problems to learn from so i made up a few

# return the sum of an array of numbers with the reduce method

def reduce_to_sum
  arr = [1,2,3,4,5,6,50]

  arr.reduce { |sum, num| sum + num }
end

puts reduce_to_sum

# only return a new array of numbers that have had 2 added to them

def add_two_to_num_arr
  arr = [1,2,3,4,5,6,50]
  
  pp arr.map { |num| num + 2 }
end

add_two_to_num_arr

# only return the keys from a hash where the values sum is greater that 50

def keys_where_hash_sums_are_greater_than_fifty
  hsh = {
    a: [12,50,1],
    s: [1,5,30],
    d: [50,1,90],
    f: [40,9,0]
  }

  sorted_hsh = hsh.select { |key, value| value.reduce { |acum, num| acum + num} > 50 }
  
  puts "#{sorted_hsh.keys.join(", ")} keys had values greater than fifty"
end

puts keys_where_hash_sums_are_greater_than_fifty

# only return strings from the array where the index is divisible by three

def divisables_by_three
  arr = %w(cats dogs turtles smoke horses meow phone cacti purple mike knife clock)
  return_arr = []
  arr.each_with_index { |word, index| return_arr.push(word) if index % 3 == 0 }
  return return_arr
end

puts divisables_by_three

# reverse each word in the input string and display it to the user

def reverse_every_word
  puts "enter a string of words separated by spaces"
  str = gets

  str_arr = str.split(" ")
  revesred_arr = []

  str_arr.each { |word| revesred_arr.push(word.split("").reverse.join(""))}
  puts revesred_arr.join(" ")
end

reverse_every_word

# remove friends from your friend_list if they haven't attended any of your gatherings

def remove_friends
  friend_list = {
    bob: 0,
    nancy: 5,
    caitlyn: 7,
    drew: 0,
    fred: 1
  }

  friend_list.select! { |_ , attendance| attendance > 0 }
  last_friend = friend_list.keys.last
  friend_list.delete(last_friend)
  puts "#{friend_list.keys.join(", ")}, and #{last_friend} remain your friends!"
end

remove_friends

