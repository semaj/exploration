
class ArrayHeap

  def self.create_heap
    self.new
  end

  def initialize
    @a = Array.new
  end

  def find_min
    @a.first
  end

  def insert(node)
    i = @a.size
    @a.push(node)
    heapify_up(i)
  end

  def size
    @a.size
  end

  def empty?
    @a.empty?
  end

  def extract_min!
    min = @a.min
    @a[0] = nil
    delete_min(0)
    @a.compact!
    min
  end

  def delete_min(i)
    return if children(i).include? nil
    min_child = children(i).min
    @a[i] = min_child
    if min_child == children(i).first
      @a[first_child(i)] = nil
      delete_min(first_child(i))
    else
      @a[second_child(i)] = nil
      delete_min(second_child(i))
    end
  end

  def first_child(i)
    2 * i + 1
  end

  def second_child(i)
    2 * i + 2
  end

  def heapify_up(i)
    return self if i == 0
    p_i = parent_index(i)
    parent = @a[p_i]
    node = @a[i]
    return self if node >= parent 
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

  def ==(o)
    return false if size != o.size
    size.times do 
      return false if extract_min! != o.extract_min!
    end
    true
  end
end




