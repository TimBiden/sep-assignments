require_relative 'node'

class OpenAddressing
  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    newIndex = index(key, size)
    until @items[newIndex].nil? do
      if next_open_index(newIndex) == -1
        resize
      else
        newIndex = next_open_index(newIndex)
      end
    end

    @items[newIndex] = Node.new(key, value)
  end

  def [](key)
    newIndex = index(key, size)

    if @items[newIndex].key != key
      for i in 0..size do
        if @items[i] && @items[i].key == key
          newIndex = i
          return @items[newIndex].value
        end
        newIndex = nil if @items[i] && @items[i].key != key
      end
      return nil if !newIndex
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

  def print_it
    count = 0
    puts ' '
    puts '***      ****      ***'
    puts "Array size = #{size}"
    for newIndex in 0..@items.length do
      next if @items[newIndex].nil?
      count += 1
    end
    puts "Items in array = #{count}"
    puts '***      ****      ***'
    for newIndex in 0..@items.length do
      next if @items[newIndex].nil?

      puts "The array position #{newIndex} has key of #{@items[newIndex].value} and value of: #{@items[newIndex].value}"
    end
    puts '***      ****      ***'
  end
end
