require_relative 'node'

class Tree
  attr_accessor :tree, :root

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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
