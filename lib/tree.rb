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
      # Node with only one child or no child
      if node.left_child.nil?
        return node.right_child
      elsif node.right_child.nil?
        return node.left_child
      end

      # Node with two children: Get the inorder successor
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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
