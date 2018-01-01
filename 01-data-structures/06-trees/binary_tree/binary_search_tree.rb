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

  def findParent(root, data)
    if !data || !root
      nil
    else
      if root.left && root.left.title == data
        # puts "root.left.title = #{root.left.title}"
        root
      elsif root.right && root.right.title == data
        # puts "root.right.title = #{root.right.title}"
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
      findRightMost(root.right)
    else
      root
    end
  end

  def delete(root, data)
    return nil if data.nil?

    parent = findParent(root, data)
    node = parent.left if parent.left && parent.left.title == data
    node = parent.right if parent.right && parent.right.title == data

    leaf = if root.left
             findRightMost(root.left)
           else
             findRightMost(root.right)
           end

    if node.nil?
      return nil
    else
      leaf.left = node.left if node.left
      leaf.right = node.right if node.right
      parent.left = leaf
      parent.right = nil

      unless node.nil?
        node.left = nil if node.left
        node.right = nil if node.right
        node.title = nil if node.title
        node.rating = nil if node.rating
      else
        puts "node.nil? True."
      end
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
