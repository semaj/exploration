#
n = gets.chomp.to_i
a = []
n.times do 
  a << gets.chomp.split(' ').map(&:to_i)
end

#a = [[1, 0], [0,-1],[-1,0],[0,1]]
total = []
a.each do |x, y|
  mod = 0
  ans = 0
  ans = y/x unless x == 0
  angle = Math.atan(ans) * (180/Math::PI)
  if y == 0 && x >= 0
    angle == 0 
  elsif x == 0 && y > 0
    angle = 90
  elsif x < 0 && y == 0
    angle = 180
  elsif x == 0 && y < 0
    angle = 270
  else
    if x < 0 && y < 0
      mod = 180
    elsif x < 0 && y > 0
      mod = 90
    elsif x > 0 && y < 0
      mod = 270
    else
      mod = 0
    end
  end
  total << [x, y, angle+mod]
end
#print total

total.sort! do |f,s|
  if f[2] == s[2]
    Math.hypot(f[0], f[1]) <=> Math.hypot(s[0], s[1])
  else
    f[2] <=> s[2]
  end
end
#print total

total.each {|a,b,c| puts "#{a} #{b}"}





