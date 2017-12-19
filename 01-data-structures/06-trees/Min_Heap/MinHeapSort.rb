require_relative 'node'
require 'pp'
require 'yaml'

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
        heap_sort(root)
        return
      else
        insert(root.left, node)
      end
    elsif node.rating > root.rating
      if root.right.nil?
        root.right = node
        heap_sort(root)
        return
      else
        insert(root.right, node)
      end
    end
  end

  def heap_sort(root)
    if root && root.rating.nil? || root.left && root.left.rating.nil? || root.right && root.right.rating.nil?

      # Root Left Deleted
      if root.left && root.left.rating.nil?
        heap_sort(root.left) if root.left.right || root.left.left
      end

      # Root Right Deleted
      if root.right && root.right.rating.nil?
        heap_sort(root.right) if root.right.right || root.right.left
      end

      # Root Deleted
      if root.rating && root.rating.nil?
        if root.right && root.left && root.left.rating <= root.right.rating
          # puts 'Root 1 failed.'
          root_left_to_root(root)
        elsif root.right && root.left && root.right.rating < root.left.rating
          # puts 'Root 2 failed.'
          root_right_to_root(root)
        elsif root.right
          # puts "Alternate failure 1"
          root_right_to_root(root)
        elsif root.left
          # puts "Alternate failure 2"
          root_left_to_root(root)
        end
      end

      # Sort - Nothing Deleted
    else
      if root.left && root.right && root.left.rating > root.right.rating
        left_to_right(root)
      elsif root.left && root.rating > root.left.rating
        root_left_to_root(root)
      elsif root.right && root.rating > root.right.rating
        root_right_to_root(root)
      end
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

  def delete(root, name)
    return nil if root.nil? || name.nil?
    node = find(root, name)

    node.title = nil
    node.rating = nil

    heap_sort(root)
    # print(root)
  end

  def find(root, name)
    return nil if root.nil? || name.nil?
    findArray = [root]

    findArray.each do |i|
      if i.title == name
        return i
      else
        findArray.push(i.right) unless i.right.nil?
        findArray.push(i.left) unless i.left.nil?
      end
    end
  end

  def print
    printRecursion(@root)
  end

  def printRecursion(root)
    puts "#{root.title}: #{root.rating}"
    printRecursion(root.right) unless root.right.nil?
    printRecursion(root.left) unless root.left.nil?
  end
end
