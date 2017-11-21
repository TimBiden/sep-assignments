require_relative 'node'

class OpenAddressing
  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    newIndex = index(key, size)

    if @items[newIndex]
      # puts "@items[#{newIndex}].key = #{@items[newIndex].key}"

      if next_open_index(newIndex) == -1
        resize
      else
        until @items[newIndex].nil?
          newIndex *= 3
        end
      end
    end

    puts "The newIndex for #{key} = #{newIndex}"
    @items[newIndex] = Node.new(key, value)
  end

  def [](key)
    newIndex = index(key, size)

    # puts "key = #{key}"

    if @items[newIndex].key != key
      for i in 0..15 do
        if @items[i]
          # puts "Hash position #{i} key = #{@items[i].key}"
        end

        if @items[i] && @items[i].key != key
          newIndex = i
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

  # Given an index, find the next open index in @items
  def next_open_index(index)
    index += 1 until @items[index].nil?
    index = -1 if index >= size
    # puts "Found nil. It is #{index}"
    index
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
