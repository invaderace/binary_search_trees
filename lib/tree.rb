# frozen_string_literal: true
require 'pry'

require_relative 'node.rb'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.sort.uniq, first = 0, last = array.length - 1 )
  end

  # initialize start = 0, end = length of the array - 1
  # mid = (start+end)/2
  # create a tree node with mid as root (lets call it A)
  # recursively do the following steps:
  # calculate mid of left subarray and make it root of left subtree of A.
  # calculate mid of right subarray and make it root of right subtree of A.
  def build_tree(array, first, last)
    return nil if first > last || array[first].nil?

    mid = (first + last) / 2
    root_node = Node.new(array[mid])
    root_node.left = build_tree(array, first, mid - 1)
    root_node.right = build_tree(array, mid + 1, last)
    root_node
  end

  def insert(value, comparing = @root)
    return @root = Node.new(value) if comparing.nil?
    return nil if value == comparing

    if value < comparing.value
      comparing.left.nil? ? comparing.left = Node.new(value) : insert(value, comparing.left)
    elsif value > comparing.value
      comparing.right.nil? ? comparing.right = Node.new(value) : insert(value, comparing.right)
    end
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
