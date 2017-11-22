require_relative 'linked_list'

class SeparateChaining
  attr_reader :max_load_factor

  def initialize(size)
    @max_load_factor = 0.7
    @items = Array.new(size)
    @numItems = 0
  end

  def []=(key, value)
    newItem = Node.new(key, value)
    newIndex = index(key, size)

    if @items[newIndex].nil?
      @items[newIndex] = LinkedList.new
      @items[newIndex].add_to_tail(newItem)
    else
      @items[newIndex].add_to_tail(newItem)
    end

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
    @items[newIndex].value
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    key.sum % size
  end

  # Calculate the current load factor
  def load_factor
    if @numItems.fdiv(size) > @max_load_factor
      resize
    end

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
      if oldArray[i]
        dataMove = oldArray[i].head
        newIndex = index(dataMove.key, size)
        if @items[newIndex]
          @items[newIndex].add_to_tail(dataMove)
        else
          @items[newIndex] = LinkedList.new
          @items[newIndex].add_to_front(dataMove)
        end
      end
      i += 1
    end

    @items
  end
end
