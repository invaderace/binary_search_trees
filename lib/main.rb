# frozen_string_literal: true

require_relative 'tree.rb'

tree = Tree.new(Array.new(15) { rand(100) })
tree.pretty_print
puts

puts "Tree is balanced? #{tree.balanced?}"
puts

puts "Level-order: #{tree.level_order}"
puts "Pre-order: #{tree.preorder}"
puts "Post-order: #{tree.postorder}"
puts "In-order: #{tree.inorder}"
puts

5.times { tree.insert(rand(101..150)) }
tree.pretty_print
puts

puts "Tree is balanced? #{tree.balanced?}"
puts

tree.rebalance
tree.pretty_print
puts

puts "Tree is balanced? #{tree.balanced?}"
puts

puts "Level-order: #{tree.level_order}"
puts "Pre-order: #{tree.preorder}"
puts "Post-order: #{tree.postorder}"
puts "In-order: #{tree.inorder}"
puts
