require 'set'
require 'minitest/autorun'
class UDGraph
  
  def initialize
    @one = {}
  end

  def edge_node(existing, new)
    @one[existing].add(new)
    @one[new] = Set.new [existing]
    self
  end

  def node(new)
    @one[new] = Set.new
    self
  end

  def delete(a)
    @one.delete(a)
    @one.values.each { |s| s.delete(a) }
  end
      

  def direct_link?(a, b)
    @one[a].include? b
  end

  def nodes
    Set.new @one.keys
  end

  def links(a)
    @one[a]
  end

  def all_links
    s = Set.new
    @one.each do |k, v|
      v.each do |l|
        s.add(Set.new [k, l])
      end
    end
    s
  end
end


describe UDGraph do
  before do
    @g = UDGraph.new
  end

  describe 'adding / deleting nodes' do
    before do
      @g.node(:a)
      @g.node(:b)
    end
    it 'must add them correctly' do
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
      @g.node(:a)
      @g.edge_node(:a, :b)
      @g.edge_node(:b, :c)
      @g.node(:d)
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

  describe 'getting links' do
    before do
      @g.node(:a)
      @g.edge_node(:a, :b)
      @g.edge_node(:b, :c)
      @g.node(:d)
    end

    it 'should have 2 links' do
      @g.all_links.size.must_equal 2
      @g.all_links.must_equal Set.new([Set.new([:a, :b]), Set.new([:b, :c])])
    end

    it 'should give individual node\'s links' do
      @g.links(:a).must_equal Set.new [:b]
      @g.links(:b).must_equal Set.new [:a, :c]
    end
  end

end
    




  
