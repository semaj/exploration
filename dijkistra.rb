require './graphs'
require './array_heap'

@g = Graph.new
@g.undirected(:a, :b, 7).undirected(:a, :f, 14).undirected(:a, :c, 9)
@g.undirected(:b, :c, 10).undirected(:b, :d, 15)
@g.undrected(:c, :f, 2).undirected(:c, :d, 11)
@g.undirected(:d, :e, 6)
@g.undirected(:e, :f, 9)

@undiscovered = @g.nodes
@h = {}
@h[:a] = 0

until @h.empty?

end

def search(node)
  current = @h[node]
  @g.links_full(node).each do |l|
    tentative = l.weight + current
    if tentative < (@h[l] || tentative + 1)
      @h[l] = tentative
    end
  end
  @undiscovered.delete(node)
end




