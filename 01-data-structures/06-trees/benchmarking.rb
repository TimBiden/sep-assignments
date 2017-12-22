require_relative 'Min_Heap/MinHeapSort.rb'
require_relative 'Min_Heap/node.rb'
# require_relative 'binary_tree/binary_search_tree.rb'
# require_relative 'binary_tree/node.rb'
require 'benchmark'

def min_heap(root, array)
  heap = MinBinaryHeap.new(root)

  array.each do |i|
    heap.insert(root, i)
  end

  heap
end

# Example Code
Benchmark.bm do |x|
  # find = 50
  size = 100
  array = []

  for i in 1..size do
    array.push(i)
  end
  array.shuffle!

	root = Node.new(array[0].to_s, array[0])

	nodeArray = []
  array.each do |num|
    nodeArray.push(Node.new(num.to_s, num))
  end

  x.report('inserting shuffled array into min heap') { new_heap = min_heap(root, nodeArray) }
end
