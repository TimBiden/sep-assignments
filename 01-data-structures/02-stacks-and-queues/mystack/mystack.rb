class MyStack
  attr_accessor :top

  def initialize
    @stack = []
    self.top = nil
  end

  def push(item)
    last = @stack.length
    @stack[last] = item
    self.top = @stack[-1]
  end

  def pop
    popped = @stack.delete_at(-1)
    self.top = @stack[-1]
    popped
  end

  def empty?
    if @stack.empty?
      true
    else
      false
    end
  end
end
