require_relative 'Min_Heap/MinHeapSort.rb'
require_relative 'binary_tree/binary_search_tree.rb'
require 'benchmark'

def min_heap(root, array)
  heap = MinBinaryHeap.new(root)

  array.each do |i|
    heap.insert(root, i)
  end
  return heap
end

def binary_tree(root, array)
  tree = BinarySearchTree.new(root)

  array.each do |i|
    tree.insert(root, i)
  end
  return tree
end

# Example Code
Benchmark.bm do |x|
  numToFind = 50000
  size = 100000
  array = []

  for i in 1..size do
    array.push(i)
  end
  array.shuffle!

  root = Node.new(array[0].to_s, array[0])

  treeArray = []
  array.each do |num|
    treeArray.push(Node.new(num.to_s, num))
  end

  heapArray = []
  array.each do |num|
    heapArray.push(Node.new(num.to_s, num))
  end

  # puts ' '
  # puts 'Insertion Section:'
  # x.report('Min Heap Insert:') { new_heap = min_heap(root, heapArray) }
  # x.report('Binary Tree Insert:') { new_tree = binary_tree(root, treeArray) }

  # puts ' '
  # puts 'Find String Section:'
  # heap = min_heap(root, heapArray)
  # x.report('Min Heap Find 50000:') { heap.find(root, "50000") }
  # tree = binary_tree(root, treeArray)
	# x.report('Binary Tree Find 50000:') { tree.find(root, "50000") }

  # puts ' '
  # puts 'Find Integer Section:'
  # heap = min_heap(root, heapArray)
  # x.report('Min Heap Find 50000:') { heap.find(root, numToFind) }
  # tree = binary_tree(root, treeArray)
	# x.report('Binary Tree Find 50000:') { tree.find(root, numToFind) }

  puts ' '
  puts 'Delete Section:'
  heap = min_heap(root, heapArray)
  x.report('Min Heap Delete 50000:') { heap.delete(root, numToFind) }
  tree = binary_tree(root, treeArray)
	x.report('Binary Title Delete 50000:') { tree.delete(root, numToFind) }
end
