require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    return nil if array.empty?

    sorted_unique_array = array.sort.uniq

    mid = sorted_unique_array.length / 2

    root = Node.new(sorted_unique_array[mid])

    root.left_child = build_tree(sorted_unique_array[0...mid])
    root.right_child = build_tree(sorted_unique_array[(mid + 1)..])

    root
  end

  def insert(value, node = @root)
    return Node.new(value) if node.nil?

    if value < node.data
      node.left_child = insert(value, node.left_child)
    else
      node.right_child = insert(value, node.right_child)
    end

    node
  end

  def delete(value, node = @root)
    return nil if node.nil?

    if value < node.data
      node.left_child = delete(value, node.left_child)
    elsif value > node.data
      node.right_child = delete(value, node.right_child)
    else
      if node.left_child.nil?
        return node.right_child
      elsif node.right_child.nil?
        return node.left_child
      end

      min_larger_node = find_min(node.right_child)
      node.data = min_larger_node.data
      node.right_child = delete(min_larger_node.data, node.right_child)
    end

    node
  end

  def find_min(node)
    current = node
    current = current.left_child while current.left_child
    current
  end

  def find(value, node = @root)
    return nil if node.nil?

    if value < node.data
      find(value, node.left_child)
    elsif value > node.data
      find(value, node.right_child)
    else
      node
    end
  end

  def level_order
    return [] if @root.nil?

    queue = [@root]
    result = []

    until queue.empty?
      node = queue.shift
      if block_given?
        yield(node)
      else
        result << node.data
      end

      queue << node.left_child if node.left_child
      queue << node.right_child if node.right_child
    end

    result unless block_given?
  end

  def inorder(node = @root, result = [], &block)
    return [] if node.nil?

    inorder(node.left_child, result, &block)
    if block_given?
      yield(node)
    else
      result << node.data
    end
    inorder(node.right_child, result, &block)

    result unless block_given?
  end

  def preorder(node = @root, result = [], &block)
    return [] if node.nil?

    if block_given?
      yield(node)
    else
      result << node.data
    end
    preorder(node.left_child, result, &block)
    preorder(node.right_child, result, &block)

    result unless block_given?
  end

  def postorder(node = @root, result = [], &block)
    return [] if node.nil?

    postorder(node.left_child, result, &block)
    postorder(node.right_child, result, &block)
    if block_given?
      yield(node)
    else
      result << node.data
    end

    result unless block_given?
  end

  def height(node)
    return -1 if node.nil?

    left_height = height(node.left_child)
    right_height = height(node.right_child)

    [left_height, right_height].max + 1
  end

  def depth(node, current_node = @root, current_depth = 0)
    return -1 if current_node.nil?
    return current_depth if current_node == node

    left_depth = depth(node, current_node.left_child, current_depth + 1)
    return left_depth if left_depth != -1

    right_depth = depth(node, current_node.right_child, current_depth + 1)
    right_depth
  end

  def height_and_balanced(node)
    return [0, true] if node.nil?

    left_height, left_balanced = height_and_balanced(node.left_child)
    right_height, right_balanced = height_and_balanced(node.right_child)

    balanced = left_balanced && right_balanced && (left_height - right_height).abs <= 1
    height = [left_height, right_height].max + 1

    [height, balanced]
  end

  def balanced?(node = @root)
    _, balanced = height_and_balanced(node)
    balanced
  end

  def rebalance
    values = inorder_array(@root)
    sorted_unique_values = values.sort.uniq
    @root = build_tree(sorted_unique_values)
  end

  def inorder_array(node, result = [])
    return result if node.nil?

    inorder_array(node.left_child, result)
    result << node.data
    inorder_array(node.right_child, result)

    result
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
