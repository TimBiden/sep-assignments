require_relative 'benchmarking'
require_relative 'node'

class LinkedList
  attr_accessor :head
  attr_accessor :tail

  # This method creates a new `Node` using `data`,
  # and inserts it at the end of the list.
  def add_to_tail(node)
    if @tail.nil? && @head.nil?
      @tail = node
      @head = @tail
    else
      @tail.next = node
      @tail = node
    end
  end

  # This method removes the last node in the lists and
  # must keep the rest of the list intact.
  def remove_tail
    if @head != @tail
      current = @head
      current = current.next if current.next != @tail
      current.next = nil
      @tail = current
    else
      @tail = nil
      @head = nil
      @tail
    end
  end

  # This method prints out a representation of the list.
  def print
    node = @head
    until node.nil?
      puts node.data
      node = node.next
    end
  end

  # This method removes `node` from the list and must keep
  # the rest of the list intact.
  def delete(node)
    if node == @head
      remove_front
    elsif node == @tail
      remove_tail
    else
      current = @head
      current = current.next while current.next != node
      current.next = node.next
    end
  end

  # This method adds `node` to the front of the list and must set the list's head to `node`.
  def add_to_front(node)
    node.next = @head
    @head = node
  end

  # This method removes and returns the first node in the
  # Linked List and must set Linked List's head to the
  # second node.
  def remove_front
    @head = @head.next
  end

  # Find the node by data passed, return node value
  # so node can be deleted.
  def find_data(node_data)
    node = @head
    until node.data == node_data
      node = node.next
    end

    node
  end
end
