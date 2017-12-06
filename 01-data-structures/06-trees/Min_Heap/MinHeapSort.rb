require_relative 'node'

class MinBinaryHeap
  attr_accessor :root

  def initialize(root)
    @root = root
    @bottomChildren = 0
    @bottomRow = 2
  end

  def insert(root, node)
    # If root rating > node rating, swap and recurse.
    if root.rating > node.rating

      # Swap values
      @root = node
      node = root

      # Recursion
      insert(@root, node)

    elsif root.rating < node.rating

      if root.left.nil?
        # Insert node into left if open
        node.parent, root.left = root.left, node.parent
        @bottomChildren += 1
      elsif root.right.nil?
        # Insert node into right if open
        node.parent, root.right = root.right, node.parent
        @bottomChildren += 1
      else
        bottomHalf = @bottomRow / 2
        if @bottomChildren < bottomHalf
          insert(root.left, node)
        elsif @bottomChildren >= bottomHalf && @bottomChildren < @bottomRow
          insert(root.right, node)
        elsif @bottomChildren == @bottomRow
          @bottomChildren = 0
          @bottomRow = @bottomRow * 2
          insert(root.left, node)
        else
          puts "D'oh! Bottom Half issue."
        end
      end
    else
      puts "Are the ratings equal?"
    end
  end

  def find(root, name)
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

  def delete(root, name)
    if name.nil?
      return nil
    else
      toDelete = self.find(root, name)
      toDelete.rating = nil
      toDelete.title = nil
    end
  end
end
