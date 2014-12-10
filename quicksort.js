
var a = [5, 1, 2, 4, 7, 8, 9, 3];

function quicksort(array) {
  var less = [];
  var equal = [];
  var greater = [];
  if (array.length > 1) {
    pivot = array[0];
    for (y in array) {
      var x = array[y];
      if (x < pivot) less.push(x);
      else if (x == pivot) equal.push(x);
      else if (x > pivot) greater.push(x);
    }
    return less.concat(equal).concat(greater);
  }
}
console.log(quicksort(a));
