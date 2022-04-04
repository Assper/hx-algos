import src.helpers.Comparator;

class Main {
  static public function main(): Void {
    function compare(a: Int, b: Int): CompareResult {
      var result = a - b;
      if (result < 0) return Less;
      if (result > 0) return Greater;
      return Equal;
    }

    var comparator = new Comparator();
    trace(comparator.lessThanOrEqual(1, 2));
    comparator = comparator.reverse();
    trace(comparator.lessThanOrEqual(1, 2));
  }
}
