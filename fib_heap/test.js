
QUnit.test( "Node#new", function( assert ) {
  var n = Node(true, 15);
  assert.deepEqual(n.previous, n, "First node's next is itself");
  assert.deepEqual(n.next, n, "First node's previous is itself");
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
