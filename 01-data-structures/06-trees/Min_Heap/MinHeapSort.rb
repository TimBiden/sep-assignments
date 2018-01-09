require_relative 'node'
require 'benchmark'

class MinBinaryHeap
  attr_accessor :root

  def initialize(root)
    @root = root
  end

  def insert(root, node)
    return false if root.nil?

    if node.rating <= root.rating
      if root.left.nil?
        root.left = node
        @lastLeaf = root.left
        heap_sort(root)
        return
      else
        insert(root.left, node)
      end
    elsif node.rating > root.rating
      if root.right.nil?
        root.right = node
        @lastLeaf = root.right
        heap_sort(root)
        return
      else
        insert(root.right, node)
      end
    end
  end

  def heap_sort(root)
    if root.left && root.right && root.left.rating > root.right.rating
      left_to_right(root)
    elsif root.left && root.rating > root.left.rating
      root_left_to_root(root)
    elsif root.right && root.rating > root.right.rating
      root_right_to_root(root)
    end
  end

  def moveLeaf(one, other)
    if one == @lastLeaf
      @lastLeaf = other
    else
      @lastLeaf = one
    end
  end

  def left_to_right(root)
    root.left.title, root.right.title = root.right.title, root.left.title
    root.left.rating, root.right.rating = root.right.rating, root.left.rating
    moveLeaf(root.left, root.right) if root.left == @lastLeaf || root.right == @lastLeaf
    heap_sort(root)
  end

  def root_left_to_root(root)
    root.left.title, root.title = root.title, root.left.title
    root.left.rating, root.rating = root.rating, root.left.rating
    moveLeaf(root.left, root) if root.left == @lastLeaf || root == @lastLeaf
    heap_sort(@root)
  end

  def root_right_to_root(root)
    root.right.title, root.title = root.title, root.right.title
    root.right.rating, root.rating = root.rating, root.right.rating
    moveLeaf(root, root.right) if root == @lastLeaf || root.right == @lastLeaf
    heap_sort(@root)
  end

  def findParent(root, name)
    return nil if root.nil? || name.nil?

    if name.is_a? Integer
      if root.right && root.right.rating == name || root.left && root.left.rating == name
        @parentVar = root
      else
        findParent(root.left, name) unless root.left.nil?
        findParent(root.right, name) unless root.right.nil?
      end
    else
      if root.right && root.right.title == name || root.left && root.left.title == name
        @parentVar = root
      else
        findParent(root.left, name) unless root.left.nil?
        findParent(root.right, name) unless root.right.nil?
      end
    end
  end

  def delete(root, data)
    return nil if !data || !root

    findParent(root, data)
    nodeParent = @parentVar
    findParent(root, data)
    leafParent = @parentVar

    # If the item being deleted is lastLeaf
    if @lastLeaf.title == data
      if nodeParent.right && nodeParent.right.title == data
        node = nodeParent.right
        nodeParent.right = nil
      else
        node = nodeParent.left
        nodeParent.left = nil
      end
      node = nil
    else
      node = nodeParent.right if nodeParent.right && nodeParent.right.title == data
      node = nodeParent.left if nodeParent.left && nodeParent.left.title == data

      @lastLeaf.left = node.left if node.left
      @lastLeaf.right = node.right if node.right
      nodeParent.left = @lastLeaf if nodeParent.left && nodeParent.left.title == data
      nodeParent.right = @lastLeaf if nodeParent.right && nodeParent.right.title == data
      leafParent.left = nil if leafParent.left && leafParent.left.title == data
      leafParent.right = nil if leafParent.right && leafParent.right.title == data
      node = nil
    end
    heap_sort(root)
  end

  def find(root, name)
    return nil if root.nil? || name.nil?

    if root.title == name
      return root
    else
      find(root.left, name) unless root.left.nil?
      find(root.right, name) unless root.right.nil?
    end
  end

  def print
    printRecursion(@root)
  end

  def printRecursion(root)
    puts "#{root.title}: #{root.rating}"
    printRecursion(root.left) unless root.left.nil?
    printRecursion(root.right) unless root.right.nil?
  end
end
