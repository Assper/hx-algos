package src.structures.linked_list;

class LinkedNode<T> {
  public final value: T;
  public var next: Null<LinkedNode<T>>;

  public function new(value: T, ?next: LinkedNode<T>) {
    this.value = value;
    this.next = next;
  }

  public function toString(): String {
    return cast(this.value, String);
  }
}
