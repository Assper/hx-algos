package src.helpers;

enum CompareResult {
  Less;
  Greater;
  Equal;
}

typedef CompareFn<T> = (a: T, b: T) -> CompareResult;

class Comparator<T> {
  private final compare: CompareFn<T>;

  private static function defaultCompare<T>(a: T, b: T): CompareResult {
    if (a == b) {
      return Equal;
    }

    return cast(a, Int) < cast(b, Int) ? Less : Greater;
  }

  public function new(?compareFn: CompareFn<T>) {
    this.compare = compareFn != null ? compareFn : Comparator.defaultCompare;
  }

  public function equal(a: T, b: T): Bool {
    return this.compare(a, b) == Equal;
  }

  public function lessThan(a: T, b: T): Bool {
    return this.compare(a, b) == Less;
  }

  public function greaterThan(a: T, b: T): Bool {
    return this.compare(a, b) == Greater;
  }

  public function lessThanOrEqual(a: T, b: T): Bool {
    return this.lessThan(a, b) || this.equal(a, b);
  }

  public function greaterThanOrEqual(a: T, b: T): Bool {
    return this.greaterThan(a, b) || this.equal(a, b);
  }

  public function reverse(): Comparator<T> {
    function compare(a: T, b: T): CompareResult {
      return this.compare(b, a);
    }
    return new Comparator(compare);
  }
}
