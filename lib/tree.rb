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

  def level_order(node = @root)
    # store root in queue.
    # visit it.
    # enqueue left child, right child.
    # visits left, queue children.
    # visit right, queue children.
    # visit and queue, in order of queue (left to right)

    # if root is null, return
    return if node.nil?

    level_order = []
    # create queue pointer to null
    # push root/node into enqueue
    queue = []
    queue.push(node)

    # while queue is not empty
    until queue == []
      # take a node from the front.
      # read that data.
      node = queue[0]
      # if left isn't null, insert into the queue.
      queue.push(node.left) unless node.left.nil?
      # if right isn't null, insert into the queue.
      queue.push(node.right) unless node.right.nil?
      # remove/pop element from front.
      level_order.push(queue.shift().value)
    end
    level_order
  end

  def inorder(node = @root, array = [])
    return if node.nil?

    inorder(node.left, array)
    array.push(node.value)
    inorder(node.right, array)
    array
  end

  def preorder(node = @root, array = [])
    return if node.nil?

    # binding.pry
    array.push(node.value)
    # binding.pry
    preorder(node.left, array)
    preorder(node.right, array)
    array
  end

  def postorder(node = @root, array = [])
    return if node.nil?

    postorder(node.left, array)
    postorder(node.right, array)
    array.push(node.value)
    array
  end

  def height(node)
    return -1 if node.nil?

    leftheight = height(node.left)
    rightheight = height(node.right)
    return max(leftheight, rightheight) + 1
  end

  def max(a, b)
    a > b ? a : b
  end

  def depth(node, parent = @root, depth = 0)
    return if node.nil?

    return depth if node.value.eql? parent.value

    if node.value < parent.value
      depth(node, parent.left, depth + 1)
    elsif node.value > parent.value
      depth(node, parent.right, depth + 1)
    end
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
