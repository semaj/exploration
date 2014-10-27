class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def self.distance(p1, p2)
    Math.hypot(p1.x - p2.x, p1.y - p2.y)
  end

  def inspect
    "[#{x}, #{y}]"
  end

  def to_s
    inspect
  end

  def ==(o)
    x == o.x && y == o.y
  end
end



p = Point.new(-2, 1)
pp = Point.new(1, 5)

ps = 10.times.collect do 
  Point.new(rand(1..50), rand(1..50))
end
print ps
puts ""
min = nil
minp = nil
ps.each do |p|
  ps.each do |p2|
    next if p == p2
    d = Point.distance(p, p2)
    minp = [p, p2] if min.nil? || d < min
  end
end
puts minp
