lines = gets.chomp.to_i
nums = []
lines.times do 
  nums << gets.chomp.to_i
end

nums.delete_if { |x| nums.count(x) % 2 == 0 }.size
combs = []
freqs = {}
(0 ... nums.length).each do |i|
  (i ... nums.length).each do |j|
    c = nums[i..j]
    k = c.inject {|s, n| s ^ n}
    freqs[k] ||= 0
    freqs[k] += 1
  end
end

key = nil
val = 0
freqs.each do |k,v|
  if v > val
    val = v
    key = k
  elsif v == val && k < (key || k+1)
    val = v
    key = k
  end
end
 
puts key.to_s + ' '  + val.to_s






