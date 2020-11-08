# Implement a method #stock_picker that takes in an array of stock prices, one for each hypothetical day. It should return a pair of days representing the best day to buy and the best day to sell. Days start at 0.

#   > stock_picker([17,3,6,9,15,8,6,1,10])
#   => [1,4]  # for a profit of $15 - $3 == $12

example_arr = [17,3,6,9,15,8,6,1,10]

def stock_picker(day_arr)
  temp_arr = []

  # substract the first value from the second value to find the one with the greatest difference
  # make a loop that sets the first value to 'x'
  #   then do another loop from the index of 'x' + 1 so it doesn't compare against itself
  #     in this loop create a hash with the key as the difference and the values being an array of indexes
  #
  #     select the largest difference key and return that and push it to an array of arrays
  #
  #   finally, select the array where the difference is the greatest

  hsh = {}

  day_arr.each_with_index do |date, idx1|
    first_date = date
    day_arr.each_with_index do |second_date, idx2|
      if idx1 < idx2
        hsh[(first_date - second_date)] = [idx1, idx2]
      end
    end
  end

  biggest_diff = hsh.min_by { |key, value| key }
  p biggest_diff[1]
end

stock_picker(example_arr)

