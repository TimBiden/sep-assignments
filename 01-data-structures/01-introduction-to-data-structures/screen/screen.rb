require_relative 'pixel'

class Screen
  attr_accessor :width
  attr_accessor :height
  attr_accessor :matrix

  def initialize(width, height)
    self.width = width
    self.height = height
  end

  # Insert a Pixel at x, y
  def insert(pixel, x, y)
    if inbounds(x, y)

    end
  end

  def at(x, y)
    self.x = x
    self.y = y
  end

  private

  def inbounds(x, y)
    if x > self.width && x > 0 && y > self.height && y > 0
      true
    else
      false
    end
  end
end
