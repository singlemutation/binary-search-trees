# frozen_string_literal: true

#
# Create binary search tree
class Tree
  attr_accessor :data, :root

  def initialize(array)
    @data = array.sort.uniq
    @root = build_tree(data)
  end

  def build_tree(array)
    return nil if array.empty?

    middle = array.length / 2
    node = Node.new(array[middle])
    node.left = build_tree(array[0...middle])
    node.right = build_tree(array[(middle + 1)..])
    node
  end

  def insert(key, node = @root)
    return Node.new(key) if node.nil?

    if key < node.data
      node.left = insert(key, node.left)
    elsif key > node.data
      node.right = insert(key, node.right)
    end
    node
  end

  def delete(key, node = @root)
    return node if node.nil?

    if key < node.data
      node.left = delete(key, node.left)
    elsif key > node.data
      node.right = delete(key, node.right)
    else
      if node.left.nil?
        tmp = node.right
        node = nil
        return tmp
      elsif node.right.nil?
        tmp = node.left
        node = nil
        return tmp
      end
      tmp = min_value(node.right)
      node.data  = tmp.data
      node.right = delete(node.data, node.right)
    end
    node
  end

  def min_value(node)
    minv = node
    while node.left
      minv = node.left
      node = node.left
    end
    minv
  end

  def find(key, node = @root)
    return 'nil' if node.nil?
    return node if node.data == key

    if key < node.data
      node.left = find(key, node.left)
    elsif key > node.data
      node.right = find(key, node.right)
    end
  end

  def level_order(node = @root)
    return nil if node.nil?

    if block_given?
      queue = []
      queue << @root
      until queue.empty?
        node = queue.first
        queue.shift
        yield node
        queue << node.left unless node.left.nil?
        queue << node.right unless node.right.nil?
      end
    else
      @data
    end
  end

  def preorder(node = @root, arr = [], &block)
    return if node.nil?

    arr << node
    preorder(node.left, arr)
    preorder(node.right, arr)
    if block_given?
      arr.each(&block)
    else
      arr.map(&:data)
    end
  end

  def inorder(node = @root, arr = [], &block)
    return if node.nil?

    inorder(node.left, arr)
    arr << node
    inorder(node.right, arr)
    if block_given?
      arr.each(&block)
    else
      arr.map(&:data)
    end
  end

  def postorder(node = @root, arr = [], &block)
    return if node.nil?

    postorder(node.left, arr)
    postorder(node.right, arr)
    arr << node
    if block_given?
      arr.each(&block)
    else
      arr.map(&:data)
    end
  end

  def height(node = @root, count = -1)
    return count if node.nil?

    count += 1
    [height(node.left, count), height(node.right, count)].max
  end

  def depth(key, node = @root, depth = 0)
    return if node.nil?
    return depth if node.data == key

    if key < node.data
      depth += 1
      node.left = depth(key, node.left, depth)
    elsif key > node.data
      depth += 1
      node.right = depth(key, node.right, depth)
    end
  end

  def balanced?(node = @root)
    return true if node.nil?

    return true if (height(node.right) - height(node.left)).abs <= 1 && balanced?(node.left) && balanced?(node.right)

    false
  end

  def rebalance
    self.data = inorder
    self.root = build_tree(data)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
