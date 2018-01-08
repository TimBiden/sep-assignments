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

  def left_to_right(root)
    root.left.title, root.right.title = root.right.title, root.left.title
    root.left.rating, root.right.rating = root.right.rating, root.left.rating
    heap_sort(root)
  end

  def root_left_to_root(root)
    # puts 'root_left_to_root reached.'
    root.left.title, root.title = root.title, root.left.title
    root.left.rating, root.rating = root.rating, root.left.rating
    # puts 'Going to heap_sort'
    heap_sort(@root)
  end

  def root_right_to_root(root)
    root.right.title, root.title = root.title, root.right.title
    root.right.rating, root.rating = root.rating, root.right.rating
    heap_sort(@root)
  end

  def findParent(root, name)
    return nil if root.nil? || name.nil?

    if name.is_a? Integer
      if root.right && root.right.rating == name || root.left && root.left.rating == name
        @parent = root
        return root
      else
        find(root.left, name) unless root.left.nil?
        find(root.right, name) unless root.right.nil?
      end
    else
      if root.right && root.right.title == name || root.left && root.left.title == name
        # puts "root.left.title = #{root.left.title}" if root.left
        # puts "root.right.title = #{root.right.title}" if root.right
        @parent = root
        return root
      else
        findParent(root.left, name) unless root.left.nil?
        findParent(root.right, name) unless root.right.nil?
      end
    end
  end

  def delete(root, data)
    return nil if !data || !root

    findParent(root, data)

    if @lastLeaf.title = data
      if @parent.right && @parent.right.title == data
        node = @parent.right
        @parent.right = nil
        node = nil
      else
        node = @parent.left
        @parent.left = nil
        node = nil
      end

    if @parent
      @node = @parent.right if @parent.right && @parent.right.title == data
      @node = @parent.left if @parent.left && @parent.left.title == data
    end

    leaf = @leafParent.right if@leafParent && @leafParent.right && @leafParent.right.title == data
    leaf = @leafParent.left if @leafParent && @leafParent.left && @leafParent.left.title == data

    if @node && leaf
      leaf.left = @node.left if @node.left
      leaf.right = @node.right if @node.right
      @parent.left = leaf if @parent.left && @parent.left.title == data
      @parent.right = leaf if @parent.right && @parent.right.title == data
      @node = nil
    elsif @node && !leaf
      @parent.left = nil if @parent.left && @parent.left.title == data
      @parent.right = nil if @parent.right && @parent.right.title == data
      @node = nil
    end
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
    # puts "#{root.title}: #{root.rating}" # For printing out question answers
    printRecursion(root.left) unless root.left.nil?
    printRecursion(root.right) unless root.right.nil?
  end
end
