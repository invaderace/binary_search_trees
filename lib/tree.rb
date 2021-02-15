# frozen_string_literal: true
require 'pry'

require_relative 'node.rb'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.sort.uniq, first = 0, last = array.length - 1 )
  end

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

  def delete(value, comparing = root)
    return @root if comparing.nil?

    if value < comparing.value
      comparing.left = delete(value, comparing.left)
    elsif value > comparing.value
      comparing.right = delete(value, comparing.right)
    else
      # the values are equal, so it needs deleted.
      return comparing.right if comparing.left.nil?
        # temp = comparing.right # even if right is nil, it's ok bc the new value will be nil
        # comparing = nil # i.e. delete
        # return temp # either the node, or nil.
      return comparing.left if comparing.right.nil?
        # temp = comparing.left # same as above.
        # comparing = nil
        # return temp
      # else
        # two children, find the smallest value node on the right.
        # look to the right, find the leftmost until it's nil.
        temp = leftmost(comparing.right)
        comparing.value = temp.value
        comparing.right = delete(temp.value, comparing.right)
      # end
    end
    return comparing
  end

  def leftmost(node)
    node = node.left until node.left.nil?
    node
  end

  def find(value, comparing = @root)

    if value < comparing.value
      # go left
      find(value, comparing.left)
    elsif value > comparing.value
      # go right
      find(value, comparing.right)
    elsif value.eql? comparing.value
      # return the Node
      return comparing
    end


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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
