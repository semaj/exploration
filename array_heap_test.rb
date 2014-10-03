require './array_heap.rb'
require 'minitest/autorun'

describe 'ArrayHeap' do
  describe '.create_heap' do
    before do
      @h = ArrayHeap.create_heap
    end

    it 'should create empty heap' do
      @h.empty?.must_equal true
      @h.size.must_equal 0
    end

    it 'should do the same thing as #new' do
      @h.must_equal ArrayHeap.new
    end
  end

  describe '#insert' do
    before do
      @h = ArrayHeap.create_heap
      @h.insert(10)
      @h.insert(100)
    end

    it 'should increment the size' do
      @h.size.must_equal 2
    end

    it 'should have a min' do
      @h.find_min.must_equal 10
    end

    it 'should not be empty' do
      @h.empty?.must_equal false
    end
  end

  describe '#children' do
    before do
      @h = ArrayHeap.create_heap
      @h.insert(50)
      @h.insert(75)
      @h.insert(80)
      @h.insert(90)
      @h.insert(100)
      @h.insert(110)
      @h.insert(120)
    end

    it 'should follow structure' do
      a = @h.to_a
      a[0].must_equal 50
      a[1].must_equal 75
      a[2].must_equal 80
      a[3].must_equal 90
      a[4].must_equal 100
      a[5].must_equal 110
      a[6].must_equal 120
    end

    it 'should have valid children' do
      @h.children(0).must_equal [75, 80]
      @h.children(1).must_equal [90, 100]
      @h.children(2).must_equal [110, 120]
    end
  end

  describe '#parent' do
    before do
      @h = ArrayHeap.create_heap
      @h.insert(80)
      @h.insert(75)
      @h.insert(50)
    end

    it 'should be valid' do
      @h.parent(1).must_equal 50
      @h.parent(2).must_equal 50
    end
  end

  describe '#extract_min!' do
    it 'should work correctly' do
      @h = ArrayHeap.create_heap
      @x = ArrayHeap.create_heap
      @h.insert(100).insert(110).insert(105).insert(80)
      @x.insert(100).insert(110).insert(105)
      @h.extract_min!.must_equal 80
      @h.must_equal @x
    end
  end

end
