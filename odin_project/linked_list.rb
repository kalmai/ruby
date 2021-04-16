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


end

class Node
  attr_accessor :value, :next_node

  def initialize(value, next_node = nil)
    @value = value
    @next_node = next_node
  end

#  def append_node(node)
#    self.next_node.nil? ? self.next_node = node : self.next_node.append_node(node)
#  end

  #def prepend_node(new_node)
  #  tmp = self.dup
  #  self.value = new_node.value
  #  self.next_node = tmp
  #end

  #def size(count = 0)
  #  unless self.nil?
  #    count += 1
  #    count = self.next_node.nil? ? count : self.next_node.size(count)
  #  end
  #end

  #def head
  #  self
  #end

  #def tail
  #  tail = self.next_node.nil? ? self : self.next_node.tail
  #end

  def at(index, i = 0)
    unless self.nil?
      index == i ? self : self.next_node.at(index, i + 1)
    end
  end

  def pop
    unless self.nil?
      if self.next_node.next_node.nil?
        self.next_node = nil
      else
        self.next_node.pop
      end
    end
  end

  def contains?(value)
    if self.value == value
      return true
    else
      return false if self.next_node.nil? 
      self.next_node.contains?(value)
    end
  end

  def find(value, index = 0)
    if self.value == value
      return index
    elsif !self.next_node.nil?
      self.next_node.find(value, index + 1)
    end
  end

  def to_s(str = "")
    self.next_node.nil? ? str << "( #{self.value} ) -> ( nil )" : self.next_node.to_s(str << "( #{self.value} ) -> ")
  end

  def insert_at(value, index)
    node_location = self.at(index)
    tmp = node_location.dup

    node_location.value = value
    node_location.next_node = tmp
  end

  def remove_at(index)
    node_location = self.at(index)
    tmp = node_location.next_node
   # node_location.value = node_location.next_node.value
   # node_location.next_node = tmp
    node_location.value = tmp.value
    node_location.next_node = tmp.next_node

  end
    
end

linked_list = LinkedList.new
linked_list.append_node(1)
linked_list.append_node(2)
linked_list.append_node(3)
linked_list.append_node(4)

#linked_list.prepend_node(69)

current = linked_list.root
until current.nil?
  puts current.value
  current = current.next_node
end

#puts linked_list.size.to_s << " this is the current size"


pp linked_list.head
pp linked_list.tail
