require_relative 'Min_Heap/MinHeapSort.rb'
require_relative 'Min_Heap/node.rb'
# require_relative 'binary_tree/binary_search_tree.rb'
# require_relative 'binary_tree/node.rb'
# require 'benchmark'


size = 100
find = 50
@array = []

for i in 1..size do
  @array.push(i)
end

@array.shuffle!

def callMinHeap
  puts "Calling the heap."

  heapArray = @array.each do |i|
    Node.new(i.to_s, i)
  end

  heap = MinBinaryHeap.new(heapArray[0])

  heapArray.each do |j|
		heap.insert(heap, j)
	end
end

callMinHeap()
