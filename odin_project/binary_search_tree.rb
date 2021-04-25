require 'pry'

class Tree
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr)
  end

  def build_tree(arr, _start = 0, _end = arr.size - 1)
    return nil if _start > _end

    mid = (_start + _end) / 2
    node = Node.new(arr[mid])

    node.left = build_tree(arr, _start, mid - 1)
    node.right = build_tree(arr, mid + 1, _end)
    
    return node
  end

  def insert(value)
    current_node = @root
    changed = false

    until changed == true
      if value.between?(current_node.left.data, current_node.right.data) 
        if current_node.right.data - value > current_node.left.data - value
          tmp = current_node.dup
          current_node.data = value
          current_node.left = tmp
          current_node.right = tmp.right
          changed = true
        elsif 
          tmp = current_node.dup
          current_node.data = value
          current_node.left = tmp.left
          current_node.right = tmp
          changed = true
        end
      end
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

class Node 
  include Comparable

  attr_accessor :data, :left, :right
  

  def initialize(data = nil)
    @data = data
    @left = nil
    @right = nil
  end

end

arr = [1,50,100]

binary_list = Tree.new(arr.uniq.sort)

binary_list.insert(69)
binary_list.insert(0)

p arr.uniq.sort
binary_list.pretty_print
