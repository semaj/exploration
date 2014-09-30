require './graphs.rb'

def graph_me_blazer
  g = Graph.new
  g.node(:a)
  g.directed_to_new(:a, :b)
  g.directed_to_new(:a, :c)
  g.directed_to_new(:c, :d)
  g.directed_existing(:c, :b)
  g.directed_to_new(:d, :e)
  g.directed_existing(:d, :a)
  g.directed_to_new(:b, :f)
  g.directed_to_new(:b, :g)
  g.directed_existing(:g, :d)
  g
end

def dfs(g, n)
  puts "doing: #{n}"
  g.discover(n)
  g.links(n).each do |l|
    dfs(g, l) unless g.discovered? l
  end
  puts "done: #{n}"
end

dfs(graph_me_blazer, :a)
  
def bfs(g, n)
  puts "doing: #{n}"
  q = g.links(n).to_a
  while !g.all_discovered? do
    l = q.pop
    puts "doing: #{l}"
    g.discover(l)
    g.links(l).each { |i| q.unshift(i) }
    puts "done: #{l}"
  end
end

bfs(graph_me_blazer, :a)


