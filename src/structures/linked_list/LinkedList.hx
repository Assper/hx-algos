package src.structures.linked_list;

import src.helpers.Comparator;

typedef FindParams<T> = {
  value: Null<T>,
  callback: Null<(value: T) -> Bool>
}

class LinkedList<T> {
  private var head: Null<LinkedNode<T>>;
  private var tail: Null<LinkedNode<T>>;
  public final compare: Comparator<T>;

  public function new(?compareFn: CompareFn<T>) {
    this.head = null;
    this.tail = null;
    this.compare = new Comparator(compareFn);
  }

  public function prepend(value): LinkedList<T> {
    final newNode = new LinkedNode(value, this.head);
    this.head = newNode;

    if (this.tail == null) {
      this.tail = newNode;
    }

    return this;
  }

  public function append(value): LinkedList<T> {
    final newNode = new LinkedNode(value);

    if (this.head == null) {
      this.head = newNode;
      this.tail = newNode;

      return this;
    }

    this.tail.next = newNode;
    this.tail = newNode;

    return this;
  }

  public function insert(value, rawIndex): LinkedList<T> {
    final index = rawIndex < 0 ? 0 : rawIndex;

    if (index == 0) {
      this.prepend(value);
    } else {
      var count = 1;
      var currentNode = this.head;
      final newNode = new LinkedNode(value);

      while (currentNode != null) {
        if (count == index) break;
        currentNode = currentNode.next;
        count += 1;
      }

      if (currentNode != null) {
        newNode.next = currentNode.next;
        currentNode.next = newNode;
      } else {
        if (this.tail != null) {
          this.tail.next = newNode;
          this.tail = newNode;
        } else {
          this.head = newNode;
          this.tail = newNode;
        }
      }
    }

    return this;
  }

  public function delete(value): Null<LinkedNode<T>> {
    if (this.head == null) {
      return null;
    }

    var deletedNode: LinkedNode<T> = null;

    while (this.head != null && this.compare.equal(this.head.value, value)) {
      deletedNode = this.head;
      this.head = this.head.next;
    }

    var currentNode = this.head;

    if (currentNode != null) {
      while (currentNode.next != null) {
        if (this.compare.equal(currentNode.next.value, value)) {
          deletedNode = currentNode.next;
          currentNode.next = currentNode.next.next;
        } else {
          currentNode = currentNode.next;
        }
      }
    }

    if (this.compare.equal(this.tail.value, value)) {
      this.tail = currentNode;
    }

    return deletedNode;
  }

  public function find(params: FindParams<T>): Null<LinkedNode<T>> {
    if (this.head == null) {
      return null;
    }

    var currentNode = this.head;

    while (currentNode != null) {
      if (params.callback != null && params.callback(currentNode.value) != null) {
        return currentNode;
      }

      if (params.value != null && this.compare.equal(currentNode.value, params.value)) {
        return currentNode;
      }

      currentNode = currentNode.next;
    }

    return null;
  }

  public function deleteTail(): LinkedNode<T> {
    final deletedTail = this.tail;

    if (this.head == this.tail) {
      this.head = null;
      this.tail = null;

      return deletedTail;
    }

    var currentNode = this.head;
    while (currentNode.next != null) {
      if (currentNode.next.next == null) {
        currentNode.next = null;
      } else {
        currentNode = currentNode.next;
      }
    }

    this.tail = currentNode;

    return deletedTail;
  }

  public function deleteHead(): LinkedNode<T> {
    if (this.head == null) {
      return null;
    }

    final deletedHead = this.head;

    if (this.head.next != null) {
      this.head = this.head.next;
    } else {
      this.head = null;
      this.tail = null;
    }

    return deletedHead;
  }

  public function fromArray(values: Array<T>): LinkedList<T> {
    for (value in values) {
      this.append(value);
    }
    return this;
  }

  public function toArray(): Array<T> {
    final nodes = [];

    var currentNode = this.head;
    while (currentNode != null) {
      nodes.push(currentNode.value);
      currentNode = currentNode.next;
    }

    return nodes;
  }

  public function toString(): String {
    return [for (value in this.toArray()) cast(value, String)].toString();
  }

  public function reverse(): LinkedList<T> {
    var currNode = this.head;
    var prevNode = null;
    var nextNode = null;

    while (currNode != null) {
      nextNode = currNode.next;
      currNode.next = prevNode;
      prevNode = currNode;
      currNode = nextNode;
    }

    this.tail = this.head;
    this.head = prevNode;

    return this;
  }
}
