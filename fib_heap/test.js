
QUnit.test( "Node#new", function( assert ) {
  var n = new Node(true, 15);
  assert.deepEqual(n.previous, n, "First node's next is itself");
  assert.deepEqual(n.next, n, "First node's previous is itself");
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

// FibHeap tests
QUnit.test( "FibHeap#find_min", function( assert ) {

});
QUnit.test( "FibHeap#merge", function( assert ) {

});
QUnit.test( "FibHeap#insert", function( assert ) {

});
QUnit.test( "FibHeap#extract_min", function( assert ) {

});
QUnit.test( "FibHeap#decrease_key", function( assert ) {

});
QUnit.test( "FibHeap#delete_el", function( assert ) {

});
