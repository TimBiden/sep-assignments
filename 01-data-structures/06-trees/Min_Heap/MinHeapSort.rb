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

  def findParent(root, name)
    return nil if root.nil? || name.nil?

    if name.is_a? Integer
      if root.right && root.right.rating == name || root.left && root.left.rating == name
        return root
      else
        find(root.left, name) unless root.left.nil?
        find(root.right, name) unless root.right.nil?
      end
    else
      if root.right && root.right.title == name || root.left && root.left.title == name
        return root
      else
        findParent(root.left, name) unless root.left.nil?
        findParent(root.right, name) unless root.right.nil?
      end
    end
  end

  def findLeafParent(root)
    return nil if root.nil?

    if root.right && !root.right.right && !root.right.left
      return root
    elsif root.left && !root.left.right && !root.left.left
      return root
    else
      findLeafParent(root.right, name) unless root.right.nil?
      findLeafParent(root.left, name) unless root.left.nil?
    end
  end

  # def delete(root, name)
  #   return nil if root.nil? || name.nil?
  #
  #   parent = findParent(root, name)
  #   if parent
  #     puts "parent = #{parent}"
  #   else
  #     puts "No parent."
  #     puts "name = #{name}"
  #   end
  #   leafParent = findLeafParent(parent)
  #   puts "leafParent = #{leafParent}"
  #
  #   if parent.right && parent.right.title == name
  #     parentRight = true
  #   elsif parent.left && parent.left.title == name
  #     parentRight = false
  #   end
  #
  #   if leafParent.right && leafParent.right.title == name
  #     leafParentRight = true
  #   elsif leafParent.left && leafParent.left.title == name
  #     leafParentRight = false
  #   end
  #
  #   if parentRight
  #     node = parent.right
  #   else
  #     node = parent.left
  #   end
  #
  #   if leafParentRight
  #     leaf = leafParent.right
  #     leaf.right = node.right if node.right
  #     leaf.left = node.left if node.left
  #   else
  #     leaf = leafParent.left
  #     leaf.right = node.right if node.right
  #     leaf.left = node.left if node.left
  #   end
  #
  #   if parentRight
  #     parent.right = leaf
  #   else
  #     parent.left = leaf
  #   end
  #
  #   leaf = nil
  #
  #   heap_sort(root)
  # end

  def delete(root, data)
    return nil if !data || !root

    findParent(root, data)

    node = @parent.right if @parent && @parent.right && @parent.right.title == data
    node = @parent.left if @parent && @parent.left && @parent.left.title == data

    replacementNode = if root.left
                        findRightMost(root.left)
                      else
                        findLeftMost(root.right)
           end

    if node.nil?
      return nil
    else
      replacementNode.left = node.left if node.left
      replacementNode.right = node.right if node.right
      @parent.left = replacementNode
      @parent.right = nil

      node.left = nil if node.left
      node.right = nil if node.right
      node.title = nil if node.title
      node.rating = nil if node.rating
    end
    node
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
