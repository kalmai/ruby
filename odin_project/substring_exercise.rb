# Implement a method #substrings that takes a word as the first argument and then an array of valid substrings (your dictionary) as the second argument. It should return a hash listing each substring (case insensitive) that was found in the original string and how many times it was found.

#  > substrings("Howdy partner, sit down! How's it going?", dictionary)
#  => { "down" => 1, "go" => 1, "going" => 1, "how" => 2, "howdy" => 1, "it" => 2, "i" => 3, "own" => 1, "part" => 1, "partner" => 1, "sit" => 1 }

# provided dictionary
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(str, dict)
  str_arr = str.split(" ")
  found_words = {}
  dict.each { |word| found_words[word] = 0 }

  alphas = ("a".."z").map {|letter| letter}
  str_arr.map! { |word| (word.split("").map! { |c| c.downcase if alphas.include?(c.downcase) } ).join("") } 

  str_arr.each do |str_word|
    dict.each do |dict_word|
      if str_word.include?(dict_word)
        found_words[dict_word] += 1
      end
    end
  end

  found_words.each { |key, value| found_words.delete(key) if found_words[key] == 0 }

  p found_words
end

substrings("Howdy partner, sit down! How's it going?", dictionary)
