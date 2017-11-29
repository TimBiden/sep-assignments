require_relative 'linked_list'

class SeparateChaining
  # attr_reader :max_load_factor

  def initialize(size)
    @max_load_factor = 0.7
    @items = Array.new(size)
    @numItems = 0
  end

  def []=(key, value)
    newItem = Node.new(key, value)
    newIndex = index(key, size)

    if !@items[newIndex]
      @items[newIndex] = LinkedList.new
    end
    @items[newIndex].add_to_tail(newItem)

    @numItems += 1
  end

  def [](key)
    newIndex = index(key, size)
    if @items[newIndex]
      data = @items[newIndex].head
      while data
        if data.key == key
          return data.value
        else
          data = data.next
        end
      end
    end
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    key.sum % size
  end

  # Calculate the current load factor
  def load_factor
    resize if @numItems.fdiv(size) > @max_load_factor

    @numItems.fdiv(size)
  end

  # Simple method to return the number of items in the hash
  def size
    @items.length
  end

  # Resize the hash
  def resize
    newLength = (@items.length * 2)
    oldArray = @items
    @items = Array.new(newLength)

    for i in 0..oldArray.length do
      next unless oldArray[i]
      dataMove = oldArray[i].head
      newIndex = index(dataMove.key, newLength)
      while dataMove
        if !@items[newIndex]
          @items[newIndex] = LinkedList.new
        end
        @items[newIndex].add_to_tail(dataMove)
        dataMove = dataMove.next
      end
    end

    @items
  end

  def print_it
    puts ' '

    puts '***      ****      ***'
    load_factor
    puts "Array size = #{size}"
    puts "Items in array = #{@numItems}"
    puts "Load factor = #{load_factor}"
    puts '***      ****      ***'
    for newIndex in 0..@items.length do
      next if @items[newIndex].nil?

      data = @items[newIndex].head
      puts "The array position #{newIndex} has key of #{data.key} and value of: #{data.value}"
      if data.next
        data = data.next
        puts "The array position #{newIndex} has key of #{data.key} and value of: #{data.value}"
      end
    end
    puts '***      ****      ***'
  end
end
