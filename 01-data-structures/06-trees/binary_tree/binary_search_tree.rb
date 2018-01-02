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
    if !root || !data
      return nil
    end

    if root.title == data
      return root
    else
      if root.right
        find(root.right, data)
      end
      if root.left
        find(root.left, data)
      end
    end
  end

  def findParent(root, data)
    return nil if !root || !data

    puts ' '
    puts "data = #{data}"
    puts "root = #{root.title}"

    if root.title == data
      puts "We have a match!"
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
    puts ' '
    puts "data = #{data}"

    parent = findParent(root, data)
    if parent
      puts "parent = #{parent}"
    else
      puts "There's no parent!"
    end

    if parent
      if parent.right
        if parent.right.title
          node = parent.right if parent.right.title == data
        end
      end
    end

    if parent
      if parent.left
        if parent.left.title
          node = parent.left if parent.left.title == data
        end
      end
    end

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
