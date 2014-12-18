function DoubleLL(root) {
  this.list = new Node(true, root);
}

function Node(is_first, root, previous, next) {
  if (is_first) {
    this.previous = this;
    this.next = this;
  } else {
    this.previous = previous;
    this.next = next;
  }
  this.root = root;
  this.num_children = 0;
  this.children = new DoubleLL();
  this.marked = false;
}



