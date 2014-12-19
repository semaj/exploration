
QUnit.test( "Node#new", function( assert ) {
  var n = new Node(true, 15);
  assert.deepEqual(n.previous, n, "First node's next is itself");
  assert.deepEqual(n.next, n, "First node's previous is itself");
  assert.deepEqual(n.children.root, n, "Children's root is itself");
});

QUnit.test( "DoubleLL#new", function( assert ) {
  var d = new DoubleLL(0);
  assert.deepEqual(d.size, 0, "New DLL should be empty");
});

QUnit.test( "DoubleLL#add", function( assert ) {
  var d = new DoubleLL(0);
  d.add(15, "blah");
  assert.deepEqual(d.size, 1, "Should not be empty after first addition");
  assert.deepEqual(d.min.key, 15, "Should assign min (key test) to new node after first addition");
  assert.deepEqual(d.min.value, "blah", "Should assign min (value test) to new node after first addition");
  d.add(14, "else");
  assert.deepEqual(d.size, 2, "Should not be empty after second addition");
  assert.deepEqual(d.min.key, 14, "Should reassign min after lower, second addition");
  assert.deepEqual(d.min.value, "else", "Should reassign min value after lower, second addition");
});

QUnit.test( "DoubleLL#add correctly swaps", function( assert ) {
  var d = new DoubleLL(0);
  var a = d.add(3, "A");
  var b = d.add(2, "B");
  assert.deepEqual(b.previous, a, "Second's previous should be first");
  assert.deepEqual(b.next, a, "Second's previous should be first");
  assert.deepEqual(a.next, b, "First's next should be second");
  assert.deepEqual(a.previous, b, "First's previous should be second");
  assert.deepEqual(d.min, b, "D's min is B");
  var c = d.add(1, "C");
  assert.deepEqual(b.previous, a, "Second's previous still first");
  assert.deepEqual(b.next, c, "Second's next should be third");
  assert.deepEqual(c.previous, b, "Third's previous should be second");
  assert.deepEqual(c.next, a, "Third's next should be first");
  assert.deepEqual(a.next, b, "First's next should be second");
  assert.deepEqual(a.previous, c, "First's previous should be third");
  assert.deepEqual(d.min, c, "D's min is C");
});

QUnit.test( "DoubleLL#delete_el", function( assert ) {
  var d = new DoubleLL(0);
  var a = d.add(3, "A");
  var b = d.add(1, "B");
  var c = d.add(2, "C");
  assert.deepEqual(a.next, b, "A's next is b before");
  assert.deepEqual(a.previous, c, "A previous is c before");
  assert.deepEqual(b.next, c, "B next is c before");
  assert.deepEqual(b.previous, a, "B previous is a before");
  assert.deepEqual(c.next, a, "C next is a before");
  assert.deepEqual(c.previous, b, "C previous is b before");

  assert.deepEqual(d.delete_el("B"), b, "Deleting b returns b");

  assert.deepEqual(d.size, 2, "Size goes down 1");
  assert.deepEqual(a.next, c, "A's next is C");
  assert.deepEqual(a.previous, c, "A's previous is C");
  assert.deepEqual(c.next, a, "C's next is A");
  assert.deepEqual(c.previous, a, "C's previous is A");
  assert.deepEqual(d.min.value, "C", "New min is C");
});

// FibHeap tests

QUnit.test( "FibHeap#find_min", function( assert ) {
  var f = new FibHeap();
  assert.deepEqual(f.find_min(), null, "Findmin is null when empty");
  f.insert(5, "A");
  assert.deepEqual(f.find_min(), "A", "Findmin is A");
  f.insert(4, "B");
  assert.deepEqual(f.find_min(), "B", "Findmin B after insert");
  f.insert(6, "C");
  assert.deepEqual(f.find_min(), "B", "Findmin still B after C insert");
});

QUnit.test( "FibHeap#merge", function( assert ) {
  var f = new FibHeap();
  var g = new FibHeap();
  f.merge(g);
  assert.deepEqual(f.is_empty(), true, "Empty merges do nothing");
  f.insert(4, "A");
  f.insert(3, "B");
  g.insert(5, "C");
  g.insert(1, "D");
  f.merge(g);
  assert.deepEqual(f.find_min(), "D", "Find min is D after merge");

  var h = new FibHeap();
  var i = new FibHeap();
  i.insert(4, "A");
  h.merge(i);
  assert.deepEqual(h.find_min(), "A", "Find min is A after merge onto empty");
  assert.deepEqual(h.is_empty(), false, "Is not empty after merge");
});

QUnit.test( "FibHeap#insert", function( assert ) {
  var f = new FibHeap();
  assert.deepEqual(f.is_empty(), true, "Starts off empty");
  f.insert(4, "A");
  assert.deepEqual(f.is_empty(), false, "Is no longer empty");
});

QUnit.test( "FibHeap#extract_min", function( assert ) {
  var f = new FibHeap();
  f.insert(5, "A");
  f.insert(4, "B");
  f.insert(3, "C");
  f.insert(2, "D");
  assert.deepEqual(f.extract_min(), "D", "First min is D");
  assert.deepEqual(f.extract_min(), "C", "Second min is C");
  assert.deepEqual(f.extract_min(), "B", "Third min is B");
  assert.deepEqual(f.extract_min(), "A", "Fourth min is A");
});
QUnit.test( "FibHeap#decrease_key", function( assert ) {

});
QUnit.test( "FibHeap#delete_el", function( assert ) {

});
