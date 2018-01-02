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

  # # Recursive Depth First Search
  # def find(root, data)
  #   return nil if !data || !root
  #
  #   if root.title == data
  #     return root
  #   else
  #     find(root.left, data) if root.left
  #     find(root.right, data) if root.right
  #   end
  # end

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

  def findParent(root, data)
    return nil if !root || !data

    if root.right && root.right.title == data || root.left && root.left.title == data
      return root
    else
      findParent(root.right, data) if root.right
      findParent(root.left, data) if root.left
    end
  end

  def findLeftMost(root)
    if root.left
      findLeftMost(root.left)
    else
      root
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
    return nil if !data || !root

    parent = findParent(root, data)

    node = parent.right if parent && parent.right && parent.right.title == data

    node = parent.left if parent && parent.left && parent.left.title == data

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
      parent.left = replacementNode
      parent.right = nil

      node.left = nil if node.left
      node.right = nil if node.right
      node.title = nil if node.title
      node.rating = nil if node.rating
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
