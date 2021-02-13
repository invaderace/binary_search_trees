# frozen_string_literal: true
require 'pry'

require_relative 'node.rb'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array, first = 0, last = array.length - 1 )
  end

  # initialize start = 0, end = length of the array - 1
  # mid = (start+end)/2
  # create a tree node with mid as root (lets call it A)
  # recursively do the following steps:
  # calculate mid of left subarray and make it root of left subtree of A.
  # calculate mid of right subarray and make it root of right subtree of A.
  def build_tree(array, first, last)
    return nil if first > last

    mid = (first + last) / 2
    root_node = Node.new(array[mid])

    root_node.left = build_tree(array, first, mid - 1)
    root_node.right = build_tree(array, mid + 1, last)
    # left = array[0..mid - 1])
    # right = array[mid + 1..last]
    root_node
  end

  def insert(value)
  end

  def delete(value)
  end

  def find(value)
  end

  def level_order
  end

  def inorder
  end

  def preorder
  end

  def postorder
  end

  def height(node)
  end

  def depth(node)
  end

  def balanced?
  end

  def rebalance
  end
end
