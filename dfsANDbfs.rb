require './graphs.rb'

def graph_me_blazer
  g = Graph.new
  g.directed(:a, :b).directed(:a, :c)
  g.directed(:c, :d).directed(:c, :b)
  g.directed(:d, :e).directed(:d, :a)
  g.directed(:b, :f).directed(:b, :g)
  g.directed(:g, :d)
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

puts '---'
bfs(graph_me_blazer, :a)


