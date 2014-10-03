require 'set'

class Graph
  Directed = Struct.new(:a, :b, :weight)
  Undirected = Struct.new(:a, :b, :weight)
  
  def initialize
    @adjhash = {}
    @links = Set.new
    @discovered = Set.new
  end

  def all_discovered?
    Set.new(@adjhash.keys) == @discovered
  end
    
  def discover(n)
    @discovered.add(n)
  end

  def discovered?(n)
    @discovered.include? n
  end

  private def create_maybe(a, b)
    @adjhash[a] = Hash.new unless @adjhash.has_key? a
    @adjhash[b] = Hash.new unless @adjhash.has_key? b
  end

  def directed(a, b, weight = 0)
    create_maybe(a, b)
    link = Directed.new(a, b, weight)
    @adjhash[a][b] = link
    @links.add(link)
    self
  end

  def undirected(a, b, weight = 0)
    create_maybe(a, b)
    link = Undirected.new(a, b, weight)
    @adjhash[b][a] = link
    @adjhash[a][b] = link
    @links.add(link)
    self
  end

  def node(new)
    @adjhash[new] = {}
    self
  end

  def delete(a)
    @adjhash.delete(a)
    @adjhash.values.each { |s| s.delete(a) }
    @links.delete_if {|l| l.a == a || l.b == a }
    self
  end

  def direct_link?(a, b)
    @adjhash[a].keys.include? b
  end

  def nodes
    Set.new @adjhash.keys
  end

  def links_full(a)
    Set.new @adjhash[a].values 
  end

  def links(a)
    Set.new @adjhash[a].keys
  end

  def all_links
    @links
  end
end
