# Given a hash of family members, with keys as the title and an array of names as the values, use Ruby's built-in select method to gather only immediate family members' names into a new array.

def select_immediate_family_based_on_keys
family = {  uncles: ["bob", "joe", "steve"],
            sisters: ["jane", "jill", "beth"],
            brothers: ["frank","rob","david"],
            aunts: ["mary","sally","susan"]
          }
  immediate_family = Array.new()
  immediate_family.push( family.select { |k,v| (k == :sisters) || (k == :brothers) }.values)
  family.each do |key,value|
    puts "#{key}: #{value}"
  end
  puts "the immediate family members are #{immediate_family.join(', ')}"
end


# Using some of Ruby's built-in Hash methods, write a program that loops through a hash and prints all of the keys

def print_all_keys
random_hash = {
  champions: ['nami', 'lux', 'garen'],
  fun_things: ['k','vidya gaymes','soldering','torture nicholas']
}
  puts random_hash.keys
end

# Then write a program that does the same thing except printing the values.

def print_all_values
random_hash = {
  champions: ['nami', 'lux', 'garen'],
  fun_things: ['k','vidya gaymes','soldering','torture nicholas']
}
  puts random_hash.values
end



# Finally, write a program that prints both

def print_both_keys_and_values
random_hash = {
  champions: ['nami', 'lux', 'garen'],
  fun_things: ['k','vidya gaymes','soldering','torture nicholas']
}
  random_hash.each do |k,v|
    puts "#{k} is the key while the value is #{v}"
  end
end

# What method could you use to find out if a Hash contains a specific value in it? Write a program to demonstrate this use.

def contains_specific_value 
  common_pets = {a: 'dog', b: 'cat', c: 'bird', d: 'lizard',e: 'fish'}
  puts "enter a common pet type to see if it is in the hash"
  input = gets.strip.to_s
  common_pets.has_value?(input) ? (puts "#{input} is a value in the hash") : (puts "#{input} is not a value in the hash" )
end

# Write a program that prints out groups of words that are anagrams. Anagrams are words that have the same exact letters in them but in a different order.

def print_found_anagrams
  words =  %w(demo none tied evil dome mode live
          fowl veil wolf diet vile edit tide
          flow neon)

  # build the key and the values by creating a has with the .each_with_object method
  anagrams = words.each_with_object({}) do |word,hsh|
    iterator_word = word.split("").sort.join
    unless hsh.key?(iterator_word)
      hsh[iterator_word] = []
      words.each do |compare_word|
        compared_word = compare_word.split("").sort.join
        hsh[iterator_word].push(compare_word) if iterator_word == compared_word
      end
    end
  end
  anagrams.each { |_, value| p value } 
end

def menu
  puts "select one of the below methods:"
  puts "1. select_immediate_family_based_on_keys"
  puts "2. print_all_keys"
  puts "3. print_all_values"
  puts "4. print_both_keys_and_values"
  puts "5. contains_specific_value"
  puts "6. print_found_anagrams"
  puts "0. to exit"
  puts
  input = gets.to_i
  case input
    when 1 then 
      select_immediate_family_based_on_keys
      puts
      menu
      puts
    when 2 then 
      print_all_keys
      puts
      menu
      puts
    when 3 then 
      print_all_values
      puts
      menu
      puts
    when 4 then 
      print_both_keys_and_values
      puts
      menu
      puts
    when 5 then 
      contains_specific_value
      puts
      menu
      puts
    when 6 then 
      print_found_anagrams
      puts
      menu
      puts
    when 0 then exit
    else 
      puts "select a valid option"
      puts
      menu
      puts
  end
end

menu
