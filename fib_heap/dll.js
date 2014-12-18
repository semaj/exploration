function DoubleLL(root) {
  this.root = root;
  this.min = null;
  this.size = 0;
}

DoubleLL.prototype.add = function(key, value) {
  if (this.size === 0) {
    this.size = 1;
    this.min = new Node(true, key, value);
  } else {
    this.size++;
    var newNode = new Node(false, key, value, this.min, this.min.next);
    this.min.next.previous = newNode;
    this.min.next = newNode;
    if (key < this.min.key) {
      this.min = newNode;
    }
  }
  return this.min;
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
  this.marked = false;
}


