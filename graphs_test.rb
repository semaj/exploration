require './graphs'
require 'minitest/autorun'

describe Graph do
  before do
    @g = Graph.new
  end

  describe 'adding nodes' do
    before do
      @g.node(:a).node(:b)
    end
    it 'must have the nodes in the nodes set' do
      @g.nodes.must_equal Set.new [:a, :b]
    end

    it 'must have no links' do
      @g.all_links.must_be_empty
    end

    it 'must have no direct links' do
      @g.direct_link?(:a, :b).must_equal false
    end
  end

  describe 'adding / deleting nodes w/ edges' do
    before do 
      @g.undirected(:a, :b)
      @g.undirected(:b, :c)
      @g.undirected(:c, :d)
    end

    it 'should have 4 nodes' do
      @g.nodes.size.must_equal 4
    end

    it 'should have a and b direct linked' do
      @g.direct_link?(:a, :b).must_equal true
    end

    it 'should have a and d not direct linked' do
      @g.direct_link?(:a, :d).must_equal false
    end

    it 'should have a and c not direct linked' do
      @g.direct_link?(:a, :c).must_equal false
    end

    it 'should delete correctly' do
      @g.delete(:c)
      @g.links(:b).must_equal Set.new [:a]
      @g.all_links.size.must_equal 1
    end
  end

  describe 'getting undirected links' do
    before do
      @g.undirected(:a, :b, 10)
      @g.undirected(:b, :c, 9)
    end

    it 'should have 2 links' do
      @g.all_links.size.must_equal 2
      links = Set.new [Graph::Undirected.new(:a, :b, 10), Graph::Undirected.new(:b, :c, 9)]
      @g.all_links.must_equal links
    end

    it 'should give individual node\'s links' do
      @g.links(:a).must_equal Set.new [:b]
      @g.links(:b).must_equal Set.new [:a, :c]
    end
  end

  describe 'getting directed links' do
    before do
      @g.directed(:a, :b)
      @g.directed(:b, :c)
      @g.directed(:c, :d)
    end

    it 'should have 3 links' do
      @g.all_links.size.must_equal 3
      links = Set.new [Graph::Directed.new(:a, :b, 0), Graph::Directed.new(:b, :c, 0), Graph::Directed.new(:c, :d, 0)]
      @g.all_links.must_equal links
    end

    it 'should get individual links' do
      @g.links(:a).must_equal Set.new [:b]
      @g.links_full(:a).must_equal Set.new [Graph::Directed.new(:a, :b, 0)]
    end
  end
end
    




  

