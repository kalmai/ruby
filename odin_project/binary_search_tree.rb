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

  def insert(value, node = @root)
    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    elsif value > node.data
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  def delete(value, node = @root)
    if value < node.data
      if node.left.data == value && leaf?(node.left)
        binding.pry
        node.left = nil
      else
        delete(value, node.left) 
      end
    elsif value > node.data
      if node.right.data == value
      else
        delete(value, node.right) 
      end
    end

  end

  def leaf?(node)
    node.left.nil? && node.right.nil?
  end

  def single_branch?(node)
    !node.left.nil? ^ !node.right.nil?
  end

  def double_branch?(node)
    !node.left.nil? && !node.right.nil?
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

arr = [1,2,3,4]

binary_list = Tree.new(arr.uniq.sort)

binary_list.pretty_print
binary_list.delete(4)

p arr.uniq.sort
binary_list.pretty_print
