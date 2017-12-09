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
    # This should work.
    if root.rating && root.rating == 'delete'
      if root.right && root.left && root.right.rating >= root.left.rating
        root_left_to_root(root)
      elsif root.right && root.left && root.right.rating < root.left.rating
        root_right_to_root(root)
      else
        root.left && root.right.rating >= root.left.rating
      end
    end

    # Check this logic!
    if root.left && root.left.rating == 'delete'
      if root.right.rating >= root.left.rating
        root_left_to_root(root)
      else
        root_right_to_root(root)
      end
    elsif root.right && root.right.rating == 'delete'
      if root.left && root.right.rating >= root.left.rating
        root_left_to_root(root)
      else
        heap_sort(root.right) # <---- Pay attention here!
      end
    elsif root.left && root.right && root.left.rating > root.right.rating
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
    root.left.title, root.title = root.title, root.left.title
    root.left.rating, root.rating = root.rating, root.left.rating
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

    node.title = 'delete'
    node.rating = 'delete'
    heap_sort(root)

    deleteNode = find(root, "delete")
    deleteNode.title = nil
    deleteNode.rating = nil
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
end
