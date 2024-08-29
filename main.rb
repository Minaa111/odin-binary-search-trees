require_relative 'lib/tree'

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

tree.insert(100)
puts tree.pretty_print

tree.insert(55)
puts tree.pretty_print

tree.delete(55)
puts tree.pretty_print
