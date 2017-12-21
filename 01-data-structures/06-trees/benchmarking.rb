require_relative 'Min_Heap/MinHeapSort.rb'
require_relative 'Min_Heap/node.rb'
# require_relative 'binary_tree/binary_search_tree.rb'
# require_relative 'binary_tree/node.rb'
require 'benchmark'

def min_heap(shuffledArray)
	nodeArray = shuffledArray.each do |num|
		Node.new(num.to_s, num)
	end

	nodeVal = shuffledArray[0]
	puts "nodeVal = #{nodeVal}"
	heap = Node.new(nodeVal.to_s, nodeVal)

	shuffledArray.each do |i|
	  heap.insert(heap, Node.new(i.to_s, i))
	end

	return heap
end

# Example Code
Benchmark.bm do |x|
  # find = 50
  size = 100
  shuffledArray = []

  for i in 1..size do
    shuffledArray.push(i)
  end
  shuffledArray.shuffle!

	x.report('inserting shuffled shuffledArray into min heap') {new_heap = min_heap(shuffledArray)}
end
