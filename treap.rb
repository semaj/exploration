require 'forwardable'
require 'pry-byebug'

class Node

  attr_accessor :valu, :priority, :left, :right, :parent

  def initialize(parent, valu, priority)
    @parent = parent
    @valu = valu
    @priority = priority
    @right = nil
    @left = nil
  end

  def self.root(valu, priority)
    self.new(nil, valu, priority)
  end

  def insert(new_val, new_pri)
    if new_val < valu
      if left.nil?
        @left = Node.new(self, new_val, new_pri)
        return left.rotate_up
      else
        return left.insert(new_val, new_pri)
      end
    else
      if right.nil?
        @right = Node.new(self, new_val, new_pri)
        return right.rotate_up
      else
        return right.insert(new_val, new_pri)
      end
    end
  end

  def delete(val)
    n = find(val)
    if leaf?
      parent_reassign(nil)
    elsif one_child
      parent_reassign(one_child)
    else
      priority = 0
      better_child.rotate_up
      delete(val)
    end
    root
  end

  def find(findme)
    return self if valu == findme
    return left.find(findme) if findme < valu && left
    return right.find(findme) if findme > valu && right
    false
  end

  def rotate_up
    return self if prioritized?
    rotate_left if right?
    rotate_right if left?
    return root if prioritized?
    rotate_up
  end

  def rotate_right
    @parent.left = @right if @parent.left
    @right.parent = @parent if @right

    @right = @parent
    @parent.parent.left = self if @parent.left?
    @parent.parent.right = self if @parent.right?
    grand_parent = @parent.parent
    @parent.parent = self

    @parent = grand_parent
  end

  def rotate_right
    left = @left.clone
    right = @right.clone
    parent = @parent.clone
    
    @parent.left = right
    @right.parent = parent

  end

  def rotate_left
    @parent.right = @left if @parent.right
    @left.parent = @parent if @left

    @left = @parent
    @parent.parent.left = self if @parent.left?
    @parent.parent.right = self if @parent.right?
    grand_parent = @parent.parent
    @parent.parent = self

    @parent = grand_parent
  end

  def root?
    parent.nil?
  end

  def ==(other)
    other.valu == @valu && other.priority == @priority && 
      other.right == @right && other.left == @left
  end

  def to_s2

    x = "#{valu}, #{priority}: #{left.valu rescue nil} | #{right.valu rescue nil}\n"
    l = left.to_s2 unless left.nil?
    r = right.to_s2 unless right.nil?
    x.concat(l.to_s).concat(r.to_s)
  end

  def inorder
    l = left.inorder rescue []
    r = right.inorder rescue []
    l.push(self).concat(r)
  end

  def inorder_valus
    l = left.inorder rescue []
    r = right.inorder rescue []
    l.push(valu).concat(r)
  end
  
  def inorder?
    inorder == inorder.sort
  end

  def valid_heap?
    return true if leaf?
    t = true
    if left
      t = t && priority > left.priority
      t = t && left.valid_heap?
    end
    if right
      t = t && priority > right.priority
      t = t && right.valid_heap?
    end
    t
  end
  
  def leaf?
    left.nil? && right.nil?
  end

  def left?
    @parent && parent.left == self
  end

  def right?
    @parent && parent.right == self
  end

  def root
    return self if root?
    parent.root
  end

  def prioritized?
    root? || parent.priority > priority
  end

  def parent_reassign(n)
    parent.left = n if left?
    parent.right = n if right?
    @parent = n
  end

  def one_child
    return false if (left && right) || (!left && !right)
    return left || right
  end

  def better_child
    return nil if right.nil? && left.nil?
    return left unless right
    return right unless left
    self.class.min(left, right)
  end

  def self.min(one, two)
    return one if [one.valu, two.valu].min == one.valu
    two
  end

  def to_s
    "valu: #{valu} | priority: #{priority}"
  end
end

class Treap
  extend Forwardable

  def_delegators :@root, :to_s, :==, :inorder, :inorder?, :valid_heap?, :find, :inorder_valus

  def initialize(valu, priority = nil)
    priority ||= rand(1..100000000)
    @root = Node.root(valu, priority)
  end

  def insert(valu, priority = nil)
    priority ||= rand(1..100000000)
    @root = @root.insert(valu, priority)
    self
  end

  def delete(valu)
    @root = @root.delete(valu)
    self
  end

  def split(valu)
    insert(valu, @root.priority + 1)
    [@root.left, @root.right]
  end

  def merge(treap)
    treap.inorder.each { |n| treap.insert(n.valu, n.priority) }
  end

  def tree
    @root.to_s2
  end
end


#t = Treap.new(:j, 7).insert(:h, 9).insert(:c, 4).insert(:e, 1).insert(:a, 2)
#a = [:q, :w, :e, :r, :t, :y, :u, :i, :o, :p, :a, :s, :d, :f, :g, :h, :j, :k, :z, :x, :c]
#t = Treap.new(:m)
#a.each do |n|
  #t.insert(:a)
#end
#
#puts t.inorder
#puts t.valid_heap?
#puts t.tree
