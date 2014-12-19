function FibHeap() {
  this.roots = new DoubleLL(null);
}

FibHeap.prototype.is_empty = function() {
  return this.roots.size == 0;
};

FibHeap.prototype.find_min = function() {
  if (this.is_empty()) {
    return null;
  }
  return this.roots.min.value;
};

FibHeap.prototype.merge = function(other_heap) {
  if (other_heap.is_empty()) { return; }
  if (this.is_empty()) {
    this.roots = other_heap.roots;
    return;
  }
  var newmin;
  var ourmin = this.roots.min;
  var theirmin = other_heap.roots.min;
  if (ourmin.key > theirmin.key) {
    this.roots.min = theirmin;
  }
  var end1 = ourmin.next;
  var end2 = theirmin.previous;
  ourmin.next = theirmin;
  theirmin.previous = ourmin;
  end1.previous = end2;
  end2.next = end1;
};

FibHeap.prototype.insert = function(key, value) {
  this.roots.add(key, value);
};

FibHeap.prototype.extract_min = function() {
  if (this.is_empty()) { return null; }
  var newroots = this.roots.min.chilren;
  this.roots.delete_el(this.roots.min.value);
  var loop = newroots.min;
  for (var i = 0; i < newroots.size; i++) {
    loop.root = null;
    this.roots.add(loop);
    loop = loop.next;
  }
  var degrees = [];

  var loop = this.roots.min;
  for (var i = 0; i < this.roots.size; i++) {
    if (degrees[loop.children.size] === undefined) {
      degrees[loop.children.size] = loop;
    } else {
      var u = degrees[loop.children.size];
      if (u.key < loop.key) {
        loop.root = u;
        u.children.min.next = 
    }
};

FibHeap.prototype.decrease_key = function(element, new_key) {

};

FibHeap.prototype.delete_el = function(element) {

};
