require 'benchmark'

def heapSort(array)
  puts "#{array} = Original Array"

  array.unshift(nil)
  length = array.length - 1

  setParent(array, length)

  array.delete_at(0)
  puts "#{array} = Final Array"
end

def setParent(array, length)
  return array if length <= 1

  parent = length / 2

  heap(array, length, parent * 2)
end

@swapCount = 0
def topSwap(array, length)
  return array if length <= 1
  @swapCount += 1
  array[1], array[length] = array[length], array[1]

  length -= 1

  setParent(array, length)
end

def heap(array, length, left)
  right = left + 1
  parent = left / 2

  topSwap(array, length) if left < 2

  if array[left].nil?
    return array
  end

  if array[right].nil? || array[left] >= array[right] || right >= (array.length - @swapCount)
    greater = left
  else
    greater = right
  end

  if array[greater] > array[parent]
    array[greater], array[parent] = array[parent], array[greater]
    left = (parent - 1) * 2
    heap(array, length, left)
  else
    left -= 2
    heap(array, length, left)
  end
end

# array = [0, 5, 1, 4, 3, 6, 9, 8, 2, 7, 13]
# heapSort(array)

array = [248, 185, 22, 288, 128, 234, 24, 206, 220, 25, 101, 91, 107, 50, 130, 229, 124, 249, 274, 92, 155, 186, 236, 32, 88, 86, 84, 273, 183, 213, 11, 232, 190, 108, 176, 167, 35, 241, 71, 16, 228, 194, 165, 179, 56, 264, 154, 191, 272, 64]

puts Benchmark.measure {heapSort(array)}
