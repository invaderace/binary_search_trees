# get the middle element and make it root.
# recursively contruct the left subtree and make it the left subchild of the root.
# recursively contruct the right subtree and make it the right subchild of the root.



# initialize start = 0, end = length of the array - 1
# mid = (start+end)/2
# create a tree node with mid as root (lets call it A)
# recursively do the following steps:
# calculate mid of left subarray and make it root of left subtree of A.
# calculate mid of right subarray and make it root of right subtree of A.

require_relative 'tree.rb'

tree = Tree.new([1,2,3,4,5,6,7,8,9])
p tree
