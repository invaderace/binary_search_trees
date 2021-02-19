# frozen_string_literal: true

require_relative 'node.rb'

# rubocop:disable Metrics/ClassLength
# accepts an array when initialized and builds a balanced binary search tree.
class Tree
  attr_accessor :root

  def initialize(array)
    array = array.sort.uniq
    @root = build_tree(array, 0, array.length - 1)
  end

  def build_tree(array, first, last)
    return nil if first > last || array[first].nil?

    mid = (first + last) / 2
    node = Node.new(array[mid])
    node.left = build_tree(array, first, mid - 1)
    node.right = build_tree(array, mid + 1, last)
    node
  end

  def insert(value, node = @root)
    return node = Node.new(value) if node.nil?

    return nil if value == node.value

    direction = direction(value, node)
    direction == 'left' ? insert_left(value, node) : insert_right(value, node)
  end

  def insert_left(value, node)
    node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
  end

  def insert_right(value, node)
    node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
  end

  def delete(value, node = @root)
    return @root if node.nil?

    if value != node.value
      direction = direction(value, node)
      direction == 'left' ? delete_left(value, node) : delete_right(value, node)
    else
      # the values are equal, so it needs deleted.
      return node.right if node.left.nil?

      return node.left if node.right.nil?

      # look to the right, find the leftmost until it's nil.
      swap_right(node)
    end
    node
  end

  def direction(value, node)
    value < node.value ? 'left' : 'right'
  end

  def delete_left(value, node)
    node.left = delete(value, node.left)
  end

  def delete_right(value, node)
    node.right = delete(value, node.right)
  end

  def swap_right(node)
    temp = leftmost(node.right)
    node.value = temp.value
    node.right = delete(temp.value, node.right)
  end

  def leftmost(node)
    node = node.left until node.left.nil?
    node
  end

  def find(value, node = @root)
    return node if value.eql? node.value

    direction = direction(value, node)
    direction == 'left' ? find(value, node.left) : find(value, node.right)
  end

  def level_order(node = @root)
    return if node.nil?

    level_order = []
    # create queue pointer to null. root/node into enqueue.
    queue = [node]
    # while queue is not empty
    until queue == []
      # take a node from the front. read that data.
      node = queue[0]
      # if left/right child isn't null, insert into the queue.
      queue.push(node.left) unless node.left.nil?
      queue.push(node.right) unless node.right.nil?
      # remove/pop element from front.
      level_order.push(queue.shift.value)
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

    array.push(node.value)
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
    max(leftheight, rightheight) + 1
  end

  def max(val_a, val_b)
    val_a > val_b ? val_a : val_b
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

  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    return true if (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)

    false
  end

  def rebalance(tree = @root)
    @root = build_tree(inorder(tree), 0, inorder(tree).length - 1)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
# rubocop:enable Metrics/ClassLength
