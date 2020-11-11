# Build a method #bubble_sort that takes an array and returns a sorted array. It must use the bubble sort methodology (using #sort would be pretty pointless, wouldn’t it?).

# > bubble_sort([4,3,78,2,0,2])
# => [0,2,2,3,4,78]

num_arr = [4,3,78,2,0,2]

def bubble_sort(arr)
  swapped = true

  while swapped == true
    swapped = false
    for i in 0..(arr.length - 2)
      if arr[i] > arr[i + 1]
        temp = arr[i]
        arr[i] = arr[i + 1]
        arr[i + 1] = temp
        swapped = true
        break
      end
    end
  end
  return arr
end

p bubble_sort(num_arr)
