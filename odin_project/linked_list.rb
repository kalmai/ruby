require 'pry'

class LinkedList
  attr_accessor :root, :size

  def initialize
    @root = nil
    @size = 0
  end

  def append_node(value)
    if @root.nil?
      @root = Node.new(value, nil)
      @size += 1
    else
      @root = Node.new(value, @root.dup)
      @size += 1
    end
  end

  def prepend_node(value)
    current_node = @root
    tail = nil
    until current_node.next_node.nil?
      current_node = current_node.next_node
      tail = current_node if current_node.next_node.nil?
    end
    tail.next_node = Node.new(value)
    @size += 1
  end

  def size
    @size
  end

  def head
    current_node = @root
    head = nil
    until current_node.next_node.nil?
      current_node = current_node.next_node
      head = current_node if current_node.next_node.nil?
    end
    head
  end

  def tail
    puts "value #{@root.value} next node #{@root.next_node}"
    @root
  end

  def at(index)
    current_node = @root
    i = @size.dup
    return_node = nil
    return return_node if index < 0
    until !return_node.nil?
      i -= 1 if i != index
      index == i ? return_node = current_node : current_node = current_node.next_node
    end
    return_node

  end

  def pop
    @root = @root.next_node
  end

  def contains?(value)
    current_node = @root
    is_in_list = false
    until current_node.nil?
      is_in_list = true if current_node.value == value
      current_node = current_node.next_node
    end
    is_in_list
  end

  def find(value)
    found_node = nil
    current_node = @root
    until found_node || current_node.nil?
      current_node = current_node.next_node
      (found_node = current_node; break) if current_node.value == value
    end
    found_node
  end

  def to_s
    str = ""
    current_node = @root
    until current_node.nil?
      current_node.next_node.nil? ? str << " ( #{current_node.value} ) -> ( nil )" : str << " ( #{current_node.value} ) ->"
      current_node = current_node.next_node
    end
    str
  end

  def insert_at(value, index)
    current_node = at(index)
    return append_node(value) if index > @size - 1
    new_node = Node.new(value, current_node.next_node)
    current_node.next_node = new_node
    @size += 1
  end

  def remove_at(index)
    current_node = at(index)
    following_node = at(index + 1)

    if index == @size - 1
      previous_node = at(index - 1)
      @root = previous_node
      @size -= 1
    else
      following_node.next_node = previous_node
      @size -= 1
    end
  end

end

class Node
  attr_accessor :value, :next_node

  def initialize(value, next_node = nil)
    @value = value
    @next_node = next_node
  end

end

linked_list = LinkedList.new
linked_list.append_node(1)
linked_list.append_node(2)
linked_list.append_node(3)
linked_list.append_node(4)


linked_list.insert_at(69, 4)

#current = linked_list.root
#until current.nil?
#  puts current.value
#  current = current.next_node
#end
