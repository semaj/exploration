numtests = gets.chomp.to_i

total = []
numtests.times do
  gridr, gridc = gets.chomp.split(' ').map(&:to_i)
  grid = []
  gridr.times do
    grid.push(gets.chomp)
  end
  patt = []
  pattr, pattc = gets.chomp.split(' ').map(&:to_i)
  pattr.times do
    patt.push(gets.chomp)
  end
  magic = []
  index = nil
  grid.each_with_index do |l, i|
    if l.include? patt.first
      index = l.index(patt.first)
      magic = patt.zip(grid[i..-1])
    end
  end
  if magic.empty?
    total << 'NO'
    next
  end
  yep = true
  magic.each do |a, b|
    if ((b.index(a) != index) rescue true)
      yep = false
      break
    end
  end
  if yep
    total << 'YES'
  else
    total << 'NO'
  end
end

puts total

