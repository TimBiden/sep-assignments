require_relative 'node'

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
    if root.left && root.right && root.left.rating > root.right.rating
      root.left.title, root.right.title = root.right.title, root.left.title
      root.left.rating, root.right.rating = root.right.rating, root.left.rating
      heap_sort(root)
    elsif root.left && root.rating > root.left.rating
      root.left.title, root.title = root.title, root.left.title
      root.left.rating, root.rating = root.rating, root.left.rating
      heap_sort(@root)
    elsif root.right && root.rating > root.right.rating
      root.right.title, root.title = root.title, root.right.title
      root.right.rating, root.rating = root.rating, root.right.rating
      heap_sort(@root)
    end
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

  def no_children(item)
    item.rating = nil
    item.title = nil
    item = nil
  end

  def delete(root, name)
    return nil if root.nil? || name.nil?
    item = find(root, name)

    # If no child nodes:
    if !item.left && !item.right
      no_children(item)
    end

    # If only 1 child
    # Left child
    if item.left && !item.right && !item.left.left && !item.left.right
      item.title = item.left.title
      item.rating = item.left.rating
      no_children(item.left)

      # Right child
    elsif item.right && !item.left && !item.right.left && !item.right.right
      item.title = item.right.title
      item.rating = item.right.rating
      no_children(item.right)
    end
  end
end
