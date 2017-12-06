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
      # puts "Time to swap!"
      # puts "node is #{node.title}"
      # puts "root is #{root.title}"
      @root = node
      node = root
      # puts "node is #{node.title}"
      # puts "@root is #{@root.title}"

      # Recursion
      insert(@root, node)

    elsif root.rating < node.rating
      if root.left.nil?
        # Insert node into left if open
        node.parent = root
        root.left = node
        puts ' '
        puts "Top"
        puts ' '
        puts "root.title = #{root.title}"
        puts "root.rating = #{root.rating}"
        puts "root.left.title = #{root.left.title}"
        puts "root.left.rating = #{root.left.rating}"
        @bottomChildren += 1
      elsif root.right.nil?
        # Insert node into right if open
        puts "Insert into Right!"
        node.parent = root
        root.right = node
        @bottomChildren += 1
      # else
      #   bottomHalf = @bottomRow / 2
      #   if @bottomChildren < bottomHalf
      #     insert(root.left, node)
      #   elsif @bottomChildren >= bottomHalf && @bottomChildren < @bottomRow
      #     insert(root.right, node)
      #   elsif @bottomChildren == @bottomRow
      #     @bottomChildren = 0
      #     @bottomRow *= 2
      #     insert(root.left, node)
      #   else
      #     puts "D'oh! Bottom Half issue."
      #   end
      end
    else
      puts 'Are the ratings equal?'
    end
    puts ' '
    puts "Bottom"
    puts ' '
    puts "root.title = #{root.title}"
    puts "root.rating = #{root.rating}"
    puts "root.left.title = #{root.left.title}"
    puts "root.left.rating = #{root.left.rating}"
  end

  # def find(root, name)
  #   findArray = [root]
  #
  #   findArray.each do |i|
  #     if i.title == name
  #       return i
  #     else
  #       findArray.push(i.right) unless i.right.nil?
  #       findArray.push(i.left) unless i.left.nil?
  #     end
  #   end
  # end
  #
  # def delete(root, name)
  #   if name.nil?
  #     nil
  #   else
  #     toDelete = find(root, name)
  #     toDelete.rating = nil
  #     toDelete.title = nil
  #   end
  # end
  #
  # def printf(children = nil)
  #   toPrint = [@root]
  #   toPrint.flatten!
  #
  #   toPrint.each do |i|
  #     puts "#{i.title}: #{i.rating}"
  #   end
  # end
end
