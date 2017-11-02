require 'benchmark'
require_relative 'linked_list'
require_relative 'node'

n = 10_000
array = []
llist = LinkedList.new

Benchmark.bm(1) do |x|
  x.report('LList  Add:') do
    for i in 1..n do
      node = Node.new(i)
      llist.add_to_tail(node)
    end
  end

  x.report('Array  Add:') do
    for i in 1..n do
      array.push(i)
    end
  end

  puts ' '

  x.report('LList Find:') do
    temp = llist.head
    for i in 1..5000
      temp = temp.next
    end
    temp
  end

  x.report('Array Find:') do
    array[5000]
  end

  puts ' '

  x.report("List   Del:") do
    node = llist.find_data(5000)
    llist.delete(node)
  end

  x.report('Array  Del:') do
    array.delete_at(5000)
  end
end
