require 'pry'

class LinkedList
  attr_accessor :root

  def initialize
    @root = Node.new('root')
  end

end

class Node
  attr_accessor :value, :next_node

  def initialize(value = rand(10), next_node = nil)
    @value = value
    @next_node = next_node
  end

  def append_node(node)
    self.next_node.nil? ? self.next_node = node : self.next_node.append_node(node)
  end

  def prepend_node(new_node)
    tmp = self.dup
    self.value = new_node.value
    self.next_node = tmp
  end

  def size(count = 0)
    unless self.nil?
      count += 1
      count = self.next_node.nil? ? count : self.next_node.size(count)
    end
  end

  def head
    self
  end

  def tail
    tail = self.next_node.nil? ? self : self.next_node.tail
  end

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

def generate_list(list, input)
  (input).times do 
    new_node = Node.new
    list.root.append_node(new_node)
  end
end

generate_list(linked_list, 2)

#p_node = Node.new('new node here!')
#linked_list.root.prepend_node(p_node)

#puts linked_list.root.size
#linked_list.root.head
#linked_list.root.tail
#linked_list.root.at(2) 
#linked_list.root.pop
#linked_list.root.size
#linked_list.root.contains?("asdf")
#linked_list.root.find("root")
#puts linked_list.root.to_s
#linked_list.root.to_s
#puts linked_list.root
#linked_list.root.insert_at('new node here', 2)
#puts linked_list.root
#linked_list.root.remove_at(1)
#puts linked_list.root
