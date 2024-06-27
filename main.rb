# frozen_string_literal: true

require_relative 'lib/node'
require_relative 'lib/tree'

random_array = Array.new(15) { rand(1..100) }
tree = Tree.new(random_array)
tree.pretty_print
p tree.balanced?
p tree.level_order
p tree.preorder
p tree.postorder
7.times do
  tree.insert(rand(100..200))
end
tree.pretty_print
p tree.balanced?
tree.rebalance
tree.pretty_print
p tree.balanced?
p tree.level_order
p tree.preorder
p tree.postorder
