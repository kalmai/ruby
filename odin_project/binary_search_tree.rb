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
    if value == @root.data
      return @root = double_branch(node) if value == node.data
    end
    if value < node.data 
      if node.left.data == value 
        return node.left = nil if leaf?(node.left)
        return node.left = return_single_branch(node.left) if single_branch?(node.left)
        return node.left = double_branch(node.left) if double_branch?(node.left)
      else
        delete(value, node.left) 
      end
    elsif value > node.data 
      if node.right.data == value
        return node.right = nil if leaf?(node.right)
        return node.right = return_single_branch(node.right) if single_branch?(node.right)
        return node.right = double_branch(node.right) if double_branch?(node.right)
      else
        delete(value, node.right) 
      end

    end
  end

  def find(value)
    current_node = @root
    until value == current_node.data
      break if current_node.data == value
      if value < current_node.data
        current_node = current_node.left
      elsif value > current_node.data
        current_node = current_node.right
      end
    end
    current_node

  end

  def level_order
    discovered_nodes = [@root]
    tree_values = []

    until discovered_nodes.size == 0
      current_node = discovered_nodes.shift
      tree_values.push(current_node.data)

      discovered_nodes.push(current_node.left) if current_node.left
      discovered_nodes.push(current_node.right) if current_node.right

    end
    tree_values

  end

  def inorder # left, root, right
    discovered_nodes = [@root]
    tree_values = []

    until discovered_nodes.size == 0
      current_node = discovered_nodes.shift
      tree_values.push(current_node.data) if current_node.data >= @root.data
      tree_values.unshift(current_node.data) if current_node.data < @root.data
      
      discovered_nodes.push(current_node.right) if current_node.right
      discovered_nodes.unshift(current_node.left) if current_node.left
    end
    tree_values
  end

  def recur_inorder(node = @root, arr = [])
    return if node.nil?

    recur_inorder(node.left, arr)
    arr.push(node.data)
    recur_inorder(node.right, arr)
    return arr
  end

  def recur_preorder(node = @root, arr = [])
    return if node.nil?

    arr.push(node.data)
    recur_inorder(node.left, arr)
    recur_inorder(node.right, arr)
    return arr
  end

  def recur_postorder(node = @root, arr = [])
    return if node.nil?

    recur_inorder(node.left, arr)
    recur_inorder(node.right, arr)
    arr.push(node.data)
    return arr
  end

#  def height(node)
#    current_node = @root
#    height = 1
#
#    until current_node == node
#      binding.pry
#      height += 1
#      current_node = current_node.left if current_node.data > node.data
#      current_node = current_node.right if current_node.data < node.data
#    end
#    height
#
#  end

  def height(node)
    if node.nil?
      return 0
    else
      l = height(node.left)
      r = height(node.right)

      return l > r ? l + 1 : r + 1
    end
  end

  def depth(node)
    current_node = @root
    depth = 0

    until current_node.data == node.data
      depth += 1

      if current_node.data > node.data
        current_node = current_node.left
      elsif current_node.data < node.data
        current_node = current_node.right
      end

    end

    return depth
  end

  def balanced?
    left = height(@root.left)
    right = height(@root.right)
    left == right
  end

  def rebalance
    @root = build_tree(level_order)
  end



  def leaf?(node)
    node.left.nil? && node.right.nil?
  end

  def single_branch?(node)
    (node.left.nil? && !node.right.nil?) ^ (!node.left.nil? && node.right.nil?)
  end

  def double_branch?(node)
    !node.right.nil? && !node.left.nil?
  end

  def return_single_branch(node)
    if !node.left.nil? && node.right.nil?
      node.left
    elsif node.left.nil? && !node.right.nil?
      node.right
    end
  end

  def double_branch(node)
    current_node = node
    tmp_node = node.right.dup
    if !node.left.nil? && !node.right.nil?
      until current_node.left
        current_node = current_node.right
      end
    end
    current_node.left.right = tmp_node
    return current_node.left

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

# 1. Create a binary search tree from an array of random numbers (`Array.new(15) { rand(1..100) }`)
# 2. Confirm that the tree is balanced by calling `#balanced?`
# 3. Print out all elements in level, pre, post, and in order
# 4. try to unbalance the tree by adding several numbers > 100
# 5. Confirm that the tree is unbalanced by calling `#balanced?`
# 6. Balance the tree by calling `#rebalance`
# 7. Confirm that the tree is balanced by calling `#balanced?`
# 8. Print out all elements in level, pre, post, and in order
arr = Array.new(15) { rand(1..100) }

binary_list = Tree.new(arr.uniq.sort)
puts binary_list.balanced?
p binary_list.level_order
p binary_list.recur_preorder
p binary_list.recur_postorder
p binary_list.recur_inorder
(7).times { binary_list.insert(rand(101..200)) }
puts binary_list.balanced?
binary_list.rebalance
puts binary_list.balanced?
p binary_list.level_order
p binary_list.recur_preorder
p binary_list.recur_postorder
p binary_list.recur_inorder

binary_list.pretty_print
