require 'set'

class Graph
  
  def initialize
    @one = {}
  end

  def directed_to_new(existing, new)
    @one[existing].add(new)
    @one[new] = Set.new
    self
  end

  def directed_from_new(existing, new)
    @one[new] = Set.new [existing]
    self
  end

  def undirected(existing, new)
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
