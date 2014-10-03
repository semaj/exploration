
class ArrayHeap

  def self.create_heap
    self.new
  end

  def initialize
    @a = Array.new
  end

  def self.heapify(*h)
  end

  def find_min
    @a.first
  end

  def delete_min
  end

  def insert(node)
    i = @a.size
    @a.push(node)
    heapify_up(i)
  end

  def merge
  end

  def meld
  end

  def size
    @a.size
  end

  def empty?
    @a.empty?
  end

  def extract_min!
  end

  def union
  end

  def heapify_up(i)
    return self if i == 0
    p_i = parent_index(i)
    parent = @a[p_i]
    node = @a[i]
    return self if parent  node >= parent 
    @a[p_i] = node
    @a[i] = parent
    heapify_up(p_i)
  end

  def parent_index(i)
    ((i - 1) / 2.0).floor
  end

  def parent(i)
    @a[parent_index(i)]
  end

  def children(i)
    [@a[2 * i + 1], @a[2 * i + 2]]
  end
end




