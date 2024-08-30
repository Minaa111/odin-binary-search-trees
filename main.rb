require_relative 'lib/tree'

random_numbers = Array.new(15) { rand(1..100) }
puts "Original Array: #{random_numbers.inspect}"

tree = Tree.new(random_numbers)

puts tree.pretty_print
puts "Is the tree balanced?: #{tree.balanced?}"

puts

puts "Level order : #{tree.level_order.inspect}"
puts "Pre-order   : #{tree.preorder.inspect}"
puts "Post-order  : #{tree.postorder.inspect}"
puts "In-order    : #{tree.inorder.inspect}"

puts

tree.insert(101)
tree.insert(102)
tree.insert(103)
tree.insert(104)
tree.insert(105)

puts tree.pretty_print
puts "Is the tree balanced?: #{tree.balanced?}"

puts

tree.rebalance

puts tree.pretty_print
puts "Is the tree balanced?: #{tree.balanced?}"

puts

puts "Level order : #{tree.level_order.inspect}"
puts "Pre-order   : #{tree.preorder.inspect}"
puts "Post-order  : #{tree.postorder.inspect}"
puts "In-order    : #{tree.inorder.inspect}"
