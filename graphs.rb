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

  def direct_link?(a, b)
    @one[a].include? b
  end

  def nodes
    Set.new @one.keys
  end

  def links(a)
    @one[a]
  end

  def links
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

  describe 'adding nodes' do
    before do
      @g.node(:a)
      @g.node(:b)
    end
    it 'must add them correctly' do
      @g.nodes.must_equal Set.new [:a, :b]
    end

    it 'must have no links' do
      @g.links.must_be_empty
    end

    it 'must have no direct links' do
      @g.direct_link?(:a, :b).must_equal false
    end
  end

  describe 'adding nodes w/ edges' do
    before do 
      @g.node(:a)
      @g.edge_node(:a, :b)
      @g.edge_node(:b, :c)
      @g.node(:d)
    end

    it 'should have 4 nodes' do
      @g.nodes.size.must_equal 4
    end
  end


end
    




  
