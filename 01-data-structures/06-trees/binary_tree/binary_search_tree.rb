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
    puts "Data = #{data}"
    # puts "root.title = #{root.title}"
    if !data
      puts ' '
      puts "Data is nil."
      return nil
    elsif !root
      puts ' '
      puts "Root is nil."
      return nil
    else
      return root if root.title == data
      find(root.left, data) unless root.left.nil?
      find(root.right, data) unless root.right.nil?
    end
  end

  def delete(root, data)
    return nil if data.nil?

    node = find(root,data)

    unless node.nil?
      node.title = nil
      node.rating = nil
    else
      return nil
    end
  end

  # Recursive Breadth First Search
  def printf(children = nil)
    arrayIterate = []

    @root.each do |node|
      arrayIterate.push(node.left) if node.left
      arrayIterate.push(node.right) if node.right
    end

    arrayIterate.each do |node|
      puts "#{node.title}: #{node.rating}"
    end
  end
end
