# if n is 1, stop
# if n is even, repeat this process on n/2
# if n is odd, repeat this process on 3n + 1
require 'pry'

def collatz(n)
  if n == 1
    return 0
  elsif n.even?
    return 1 + collatz(n / 2)
  elsif n.odd?
    return 1 + collatz(3 * n + 1)
  end
end

# Write a method #fibs which takes a number and returns that many members of the fibonacci sequence. Use iteration for this solution.

def fibs(n)
  fib_arr = [1,1]
  (n-2).times do
    fib_arr.push(fib_arr[-1] + fib_arr[-2])
  end
  if n >= 2
    pp fib_arr
  elsif n == 1
    puts "[1]"
  else
    puts "you must enter a positive integer"
  end

end

# Now write another method #fibs_rec which solves the same problem recursively. This can be done in just 3 lines (or 1 if you’re crazy, but don’t consider either of these lengths a requirement… just get it done).

def fibs_rec(n, arr = [1,1])
  arr.size == n ? arr : (arr.push(arr[-1] + arr[-2]); fibs_rec(n, arr))
end

# on input of n elements
#   if n < 2
#     return
#   else
#     sort left half of elements
#     sort right half of elements
#     merge sorted halves

def merge_sort(arr)
  if arr.size < 2
    return arr
  else
    arr1 = merge_sort(arr.slice(0...arr.size / 2))
    arr2 = merge_sort(arr.slice(arr.size / 2...arr.size))

    arr1.each.with_index do |e1, i|
      arr2.each.with_index do |e2, ii|
        if e1 > e2
          arr1[i] = e2
          arr2[ii] = e1
        end
      end
    end
    return arr1 += arr2

  end
end

def binary_search(arr, n)
  min, max = 0, arr.size - 1
  guess = (min + max) / 2
  if arr[guess] == n
    puts arr[guess]
  elsif min > max
    puts "#{n} is not in the array"
  else
    arr[guess] > n ? binary_search(arr[0..guess - 1], n) : binary_search(arr[guess + 1..arr.size - 1], n)
  end
end

arr = 1000.times.with_object([]) { |i, arr| arr.push(i + 1) }
binary_search(arr, 600) 
