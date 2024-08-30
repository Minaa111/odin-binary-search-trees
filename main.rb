require_relative 'lib/tree'

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

puts tree.pretty_print
node = tree.find(67)
puts tree.height(node)
