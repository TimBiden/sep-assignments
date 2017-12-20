require_relative 'Min_Heap/MinHeapSort.rb'
require_relative 'Min_Heap/node.rb'
# require_relative 'binary_tree/binary_search_tree.rb'
# require_relative 'binary_tree/node.rb'
# require 'benchmark'


size = 100
find = 50

@array = []
for i in 1..size do
  @array.push({title =>i.to_s, rating => i})
end

@array.shuffle!

def callMinHeap
  puts "Calling the heap."

  heap = MinBinaryHeap.new(@array[0])

  @array.each do |node|
		heap.insert(heap.root, node)
	end
end

callMinHeap()
