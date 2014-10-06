a, b, n = gets.chomp.split(' ').map(&:to_i)

def fib(a, b, n)
  array = [a, b]
  x, y = 0, 1
  (n-2).times do 
    array.push(array[x] + array[y] ** 2)
    x += 1
    y += 1
  end
  array[n-1]
end

puts fib(a, b, n)

