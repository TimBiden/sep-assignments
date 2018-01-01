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
      nil
    else
      if root.title == data
        root
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
      root
    end
  end

  def delete(root, data)
    return nil if data.nil?

    node = find(root, data)
    @parent = root

    leaf = if root.left
                 findRightMost(root.left)
               else
                 findRightMost(root.right)
               end

    if node.nil?
      return nil
    else
      leaf.left = node.left
      leaf.right = node.right
      @parent.left = leaf
      @parent.right = nil
      node.left = nil
      node.right = nil
      node.title = nil unless node.nil?
      node.rating = nil
    end
  end

  # Recursive Breadth First Search
  def printf(_children = nil)
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
