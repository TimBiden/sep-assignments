require_relative 'node'

class OpenAddressing
  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    newIndex = index(key, self.size)

    if @items[newIndex]
      while @items[newIndex] && @items[newIndex].key != key
        newIndex += 1
      end

      if newIndex >= @items.size
        self.resize
        return self[key]= value
      end
    end

    @items[newIndex] = Node.new(key, value)
  end

  def [](key)
    newIndex = index(key, @items.size)

    until @items[newIndex].key == key || newIndex > @items.size
      newIndex += 1
    end

    @items[newIndex].value
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    key.sum(64) % size
  end

  # Given an index, find the next open index in @items
  def next_open_index(index)
    puts "index = #{index}"
    for i in index..(size - 1) do
      if @items[i].nil?
        puts "It's nil."
        return i
      else
        puts "It's NOT nil."
        i += 1
      end
    end
    puts "It's -1"
    -1
  end

  # Simple method to return the number of items in the hash
  def size
    @items.length
  end

  # Resize the hash
  def resize
    oldItems = @items
    newLength = @items.length * 2
    @items = Array.new(newLength)

    oldItems.each do |item|
      self[item.key] = item.value unless item.nil?
    end
  end
end
