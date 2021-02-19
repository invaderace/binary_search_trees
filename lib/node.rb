# frozen_string_literal: true

# a node class that stores data and left and right children.
class Node
  attr_accessor :value, :left, :right

  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end
end
