function DoubleLL(root) {
  this.root = root;
  this.min = null;
  this.size = 0;
}

DoubleLL.prototype.add = function(key, value) {
  this.size++;
  if (this.size === 1) {
    this.min = new Node(true, key, value);
    return this.min;
  } else {
    var newNode = new Node(false, key, value, this.min, this.min.next);
    this.min.next.previous = newNode;
    this.min.next = newNode;
    if (key < this.min.key) {
      this.min = newNode;
    }
    return newNode;
  }
};

DoubleLL.prototype.delete_el = function(value) {
  if (this.size === 0) { return null; }
  var loop = this.min;
  for (var i = 0; i < this.size; i++) {
    if (loop.value === value) {
      loop.previous.next = loop.next;
      loop.next.previous = loop.previous;
      if (this.min === loop) { 
        this.min = null;
        this.min = this.find_min(loop.next) 
      }
      this.size--;
      return loop;
    }
    loop = loop.next;
  }
  return null;
};

DoubleLL.prototype.find_min = function(start) {
  var loop = start;
  var min_val = loop.key;
  var min = loop;
  for (var i = 0; i < this.size; i++) {
    if (loop.value < min_val) {
      min_val = loop.value;
      min = loop;
    }
    loop = loop.next;
  }
  return min;
};

function Node(is_first, key, value, previous, next) {
  if (is_first) {
    this.previous = this;
    this.next = this;
  } else {
    this.previous = previous;
    this.next = next;
  }
  this.key = key;
  this.value = value;
  this.num_children = 0;
  this.children = new DoubleLL(this);
  this.marked = false;
}


