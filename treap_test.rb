require './treap.rb'
require 'minitest/spec'
require 'minitest/autorun'

describe Node do
  before :each do
    @n = Node.root(:b, 10)
    @nLeft = @n.clone
    @nLeft.left = Node.new(@nLeft, :a, 9)
    @nRight = @n.clone
    @nRight.right = Node.new(@nRight, :c, 8)
    @nBoth = @n.clone
    @nBoth.left = Node.new(@nBoth, :a, 9)
    @nBoth.right = Node.new(@nBoth, :c, 8)
  end

  describe '.root' do

    it 'should have nil parent & non nil other stuff' do
      @n.parent.must_be_nil
      @n.valu.must_equal :b
      @n.priority.must_equal 10
    end

    it 'should be root?' do
      @n.root?.must_equal true
    end
    
  end

  describe '#leaf?' do

    it 'should be true on root' do
      @n.leaf?.must_equal true
    end

    it 'should not be true with left or/and right' do
      @nLeft.leaf?.must_equal false
      @nRight.leaf?.must_equal false
      @nBoth.leaf?.must_equal false
    end
  end

  describe '#left?' do

    it 'not true when parent.nil?' do
      @n.left?.must_be_nil
    end

    it 'not true when parent.left != self' do
      @nRight.right.left?.must_equal false
    end

    it 'is true' do
      @nLeft.left.left?.must_equal true
    end
  end

  describe '#right?' do

    it 'not true when parent.nil?' do
      @n.right?.must_be_nil
    end

    it 'not true when parent.right != self' do
      @nLeft.left.right?.must_equal false
    end

    it 'is true' do
      @nRight.right.right?.must_equal true
    end
  end

  describe '#prioritized?' do
    it 'is true for root' do
      @n.prioritized?.must_equal true
    end

    it 'is true' do
      @nLeft.prioritized?.must_equal true
      @nRight.prioritized?.must_equal true
    end

    it 'is false' do
      n = @n.clone
      n.left = Node.new(n, :c, 1000)
      n.left.prioritized?.must_equal false
    end
  end

  describe '#parent_reassign' do
    it 'left assign' do
      left = @nLeft.left
      left.wont_be_nil
      left.left?.must_equal true
      left.parent_reassign(nil)
      left.parent.must_be_nil
      @nLeft.left.must_be_nil
    end

    it 'right assign' do
      right = @nRight.right
      right.wont_be_nil
      right.right?.must_equal true
      right.parent_reassign(nil)
      right.parent.must_be_nil
      @nRight.right.must_be_nil
    end
  end

  describe '#one_child' do
    it 'is false if both chilren' do
      @nBoth.one_child.must_equal false
    end

    it 'is false if no children' do
      @n.one_child.must_equal false
    end

    it 'returns left if left' do
      @nLeft.one_child.must_equal @nLeft.left
    end

    it 'returns right if right' do
      @nRight.one_child.must_equal @nRight.right
    end
  end

  describe '#better_child' do

    it 'is nil for leaf' do 
      @n.better_child.must_be_nil
    end
    
    it 'is left for left only' do
      @nLeft.left.wont_be_nil
      @nLeft.better_child.must_equal @nLeft.left
    end

    it 'is right for right only' do
      @nRight.right.wont_be_nil
      @nRight.better_child.must_equal @nRight.right
    end

    it 'is left when left value < right' do
      @nBoth.left.valu = :b
      @nBoth.right.valu = :c
      @nBoth.better_child.must_equal @nBoth.left
    end

    it 'is right when right value < left' do
      @nBoth.left.valu = :c
      @nBoth.right.valu = :b
      @nBoth.better_child.must_equal @nBoth.right
    end

  end


  describe '#valid_heap?' do
    it 'is true for leaves' do
      @n.valid_heap?.must_equal true
    end

    it 'is false when priority < leftpriority' do
      @nLeft.priority = -1
      @nLeft.valid_heap?.must_equal false
    end

    it 'is false when priority < rightpriority' do
      @nRight.priority = -1
      @nRight.valid_heap?.must_equal false
    end

    it 'is true when no left, right is correct' do
      @nRight.valid_heap?.must_equal true
    end

    it 'is true when no right, left is correct' do
      @nLeft.valid_heap?.must_equal true
    end

    it 'is true when both less than priority' do
      @nBoth.valid_heap?.must_equal true
    end
  end


  describe '#inorder' do
    it 'is correct' do
      @nBoth.inorder.map(&:valu).must_equal [:a, :b, :c]
    end
  end

  describe '#find' do
    it 'finds things' do
      @n.find(:b).wont_equal false
      @nLeft.find(:b).wont_equal false
      @nLeft.find(:a).wont_equal false
      @nRight.find(:b).wont_equal false
      @nRight.find(:c).wont_equal false
      @nBoth.find(:a).wont_equal false
      @nBoth.find(:b).wont_equal false
      @nBoth.find(:c).wont_equal false
    end

    it 'doesnt find things' do
      @n.find(:c).must_equal false
      @n.find(:a).must_equal false
      @nLeft.find(:c).must_equal false
      @nRight.find(:a).must_equal false
    end
  end

  describe '#rotate_right' do
    before do
      @l = @nBoth.left
      @r = @nBoth.right
      @l.left = Node.new(@l, :j, 100)
      @l.right = Node.new(@l, :k, 101)
      @l.rotate_right
    end

    it 'target should be root' do
      @l.root?.must_equal true
    end

    it 'target should have valid children' do
      @l.left.valu.must_equal :j
      @l.left.priority.must_equal 100
      @l.right.valu.must_equal :b
      @l.right.priority.must_equal 10
    end

    it 'original root should have valid children' do
      @nBoth.left.valu.must_equal :k
      @nBoth.left.priority.must_equal 101
      @nBoth.right.valu.must_equal :c
      @nBoth.right.priority.must_equal 8
    end

    it 'original root should have valid parent' do
      @nBoth.root?.must_equal false
      @nBoth.parent.must_equal @l
    end

  end

  describe '#rotate_left' do
    before do
      @l = @nBoth.left
      @r = @nBoth.right
      @r.left = Node.new(@r, :j, 100)
      @r.right = Node.new(@r, :k, 101)
      @r.rotate_left
    end

    it 'target should be root' do
      @r.root?.must_equal true
    end

    it 'target should have valid children' do
      @r.left.valu.must_equal :b
      @r.left.priority.must_equal 10
      @r.right.valu.must_equal :k
      @r.right.priority.must_equal 101
    end

    it 'original root should have valid children' do
      @nBoth.left.valu.must_equal :a
      @nBoth.left.priority.must_equal 9
      @nBoth.right.valu.must_equal :j
      @nBoth.right.priority.must_equal 100
    end

    it 'original root should have valid parent' do
      @nBoth.root?.must_equal false
      @nBoth.parent.must_equal @r
    end
  end

  describe 'rotations' do
    it 'left should be reverse of right' do
      @orig = @nBoth.clone
      @l = @nBoth.left
      @r = @nBoth.right
      @r.left = Node.new(@r, :j, 100)
      @r.right = Node.new(@r, :k, 101)
      @r.rotate_left
      @nBoth.rotate_right
      @orig.must_equal @nBoth
    end

    it 'right should be reverse of left' do
      @orig = @nBoth.clone
      @l = @nBoth.left
      @r = @nBoth.right
      @l.left = Node.new(@l, :j, 100)
      @l.right = Node.new(@l, :k, 101)
      @l.rotate_right
      @nBoth.rotate_left
      @orig.must_equal @nBoth
    end
  end

  describe 'rotate_up' do
    before do
      @d = Node.root(:d, 100)
      @b = Node.new(@d, :b, 90)
      @e = Node.new(@d, :e, 80)
      @d.right = @e
      @d.left = @b
      @a = Node.new(@b, :a, 70)
      @c = Node.new(@b, :c, 91)
      @b.left = @a
      @b.right = @c

    end

    it 'c should rotate up once' do
      @dclone = @d.clone
      @dclone.left = Node.new(@dclone, :c, 81)
      @dclone.left.left = Node.new(@dclone.left, :b, 90)
      @dclone.left.left.left = Node.new(@dclone.left.left, :a, 70)
      @c.rotate_up
      binding.pry
      @d.must_equal @dclone
    end

    it 'should return self if prioritized' do
      @n.rotate_up.must_equal @n
    end
  end

  describe 'insert' do
    before do
      @d = Node.root(:d, 100)
      @b = Node.new(@d, :b, 90)
      @e = Node.new(@d, :e, 80)
      @d.right = @e
      @d.left = @b
      @a = Node.new(@b, :a, 70)
      @b.left = @a

    end
  end
end
