package src.structures.linked_list;

import src.helpers.Comparator;

class LinkedList<T> {
  private var head: Null<LinkedNode<T>>;
  private var tail: Null<LinkedNode<T>>;
  final compare: Comparator<T>;

  function new(?compareFn: CompareFn<T>) {
    this.head = null;
    this.tail = null;
    this.compare = new Comparator(compareFn);
  }

  function prepend(value): LinkedList<T> {
    final newNode = new LinkedNode(value, this.head);
    this.head = newNode;

    if (this.tail == null) {
      this.tail = newNode;
    }

    return this;
  }
}
