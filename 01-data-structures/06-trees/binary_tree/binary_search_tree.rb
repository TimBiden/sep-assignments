require_relative 'node'

class BinarySearchTree
  def initialize(root)
    @root = root
  end

  def insert(root, node)
    if root.rating > node.rating
      if root.left
        insert(root.left, node)
      else
        root.left = node
      end
    else
      if root.right
        insert(root.right, node)
      else
        root.right = node
      end
    end
  end

  # Recursive Depth First Search
  def find(root, data)
    if !data || !root
      return nil
    else
      if root.title == data
        return root
      elsif root.left
        find(root.left, data)
      elsif root.right
        find(root.right, data)
      end
    end
  end

  def findRightMost(root)
    if root.right
      @parent = root
      findRightMost(root.right)
    else
      return root
    end
  end

  def delete(root, data)
    return nil if data.nil?

    node = find(root, data)
    @parent = root

    if root.left
      toDelete = findRightMost(root.left)
    else
      toDelete = findRightMost(root.right)
    end

    unless node.nil?
      node.title = nil
      node.rating = nil
    else
      return nil
    end
  end

  # Recursive Breadth First Search
  def printf(children = nil)
    arrayIterate = [@root]

    arrayIterate.each do |node|
      arrayIterate.push(node.left) if node.left
      arrayIterate.push(node.right) if node.right
    end

    arrayIterate.each do |node|
      puts "#{node.title}: #{node.rating}"
    end
  end
end
