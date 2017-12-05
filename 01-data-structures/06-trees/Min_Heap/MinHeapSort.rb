require_relative 'node'

class MinBinaryHeap
  attr_accessor :root

  def initialize(root)
    @root = root
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
        node.parent = root
        root.left = node

      elsif root.right.nil?

        # Insert node into right if open
        node.parent = root
        root.right = node

      else
        puts "Figure this step out next..."
      end
    end
  end
end
