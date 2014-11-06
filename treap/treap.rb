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
    if n.leaf?
      n.parent_reassign(nil)
    elsif n.one_child
      n.parent_reassign(n.one_child)
    else
      n.priority = 0
      n.better_child.rotate_up
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
    return root if prioritized?
    if right?
      rotate_left
    elsif left?
      rotate_right
    end
    return root if prioritized?
    rotate_up
  end

  def rotate_right
    parent_left = @parent.left?
    @parent.left = @right
    @right.parent = @parent if @right

    grand_parent = @parent.parent
    @parent.parent = self
    @right = @parent
    if grand_parent
      grand_parent.left = self if parent_left
      grand_parent.right = self if !parent_left
    end

    @parent = grand_parent
  end

  def rotate_right2
    tright = @right.clone
    tparent = @parent.clone
    
    tright.parent = tparent
    tparent.left = tright
    grand_parent = tparent.parent
    tparent.parent = self

    @right = tparent
    grand_parent.left = self if @parent.left?
    grand_parent.right = self if @parent.right?
    @parent = grand_parent
  end

  def rotate_left
    parent_left = @parent.left?
    @parent.right = @left
    @left.parent = @parent if @left

    grand_parent = @parent.parent
    @parent.parent = self
    @left = @parent
    if grand_parent
      grand_parent.left = self if parent_left
      grand_parent.right = self if !parent_left
    end

    @parent = grand_parent
  end

  def root?
    parent.nil?
  end

  def ==(other)
    return false if other.nil?
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
    l = left.inorder_valus rescue []
    r = right.inorder_valus rescue []
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

  def_delegators :@root, :to_s, :inorder, :inorder?, :valid_heap?, :find, :inorder_valus

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
    r = @root.clone.insert(valu, @root.priority + 1)
    [r.left, r.right]
  end

  def merge(treap)
    treap.inorder.each { |n| treap.insert(n.valu, n.priority) }
  end

  def ==(other)
    inorder_valus == other.inorder_values
  end
end

